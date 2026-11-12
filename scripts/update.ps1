param([int]$ThrottleLimit = 8)

function get-current-version
{
    $matched = Select-String -Path "./recipe.yaml" -Pattern '^  version: (\S+)'
    $v = $matched.Matches[0].Groups[1]
    $v = "$v".Replace("""", "")
    Write-Output $v
}

# Function: Get the latest release tag from a GitHub repository
function get-version-github
{
    param($repo)
    for ($i = 0; $i -lt 5; $i++)
    {
        $latest = gh release view -R $repo --json tagName -q .tagName
        $latest = "$latest".Replace("v", "")
        if ($latest)
        {
            return $latest
        }
    }
}

function get-version-conda-forge
{
    param($pkg)
    for ($i = 0; $i -lt 5; $i++)
    {
        $latest = curl -s "https://api.anaconda.org/package/conda-forge/$pkg" | jq -r '.latest_version'
        if ($latest)
        {
            return $latest
        }
    }
}

function get-version-crateio
{
    param($name)
    for ($i = 0; $i -lt 5; $i++)
    {
        $latest = curl -s -H "User-Agent: gh-actions-ci" https://crates.io/api/v1/crates/$name | jq -r '.crate.max_version'
        if ($latest)
        {
            return $latest
        }
    }
}

function get-version-winget
{
    param($name)
    gh api repos/microsoft/winget-pkgs/contents/manifests/$name | jq -r '[.[].name| select(test("^[0-9]+(\\.[0-9]+)*$"))]| sort_by(split(".") | map(tonumber))| last'
}
function get-version-url
{
    param($url, $pattern)
    for ($i = 0; $i -lt 5; $i++)
    {
        $html = curl -sL $url
        $versions = [regex]::Matches($html, $pattern) | `
                ForEach-Object { $_.Groups[1].Value }
        $latest = $versions | `
                Sort-Object { [version]$_ } -Descending | `
                Select-Object -First 1
        if ($latest)
        {
            return $latest
        }
    }
}

function get-version-text
{
    param($text, $pattern)

    $versions = [regex]::Matches($text, $pattern) | `
            ForEach-Object { $_.Groups[1].Value }
    $latest = $versions | `
            Sort-Object { [version]$_ } -Descending | `
            Select-Object -First 1
    return $latest
}

function get-changelog-github
{
    param($repo, $prefix="")
    if ($prefix)
    {
        Write-Output "https://github.com/$repo/releases/tag/$prefix$version"
    } else
    {
        Write-Output "https://github.com/$repo/releases/latest"
    }
}

# Emit a summary-table row. The main thread collects these (in package order)
# and writes them to $GITHUB_STEP_SUMMARY, so parallel jobs never interleave rows.
function add-summary-row
{
    param($row)
    Write-Output "::row::$row"
}

function update-recipe
{
    param($pkg_name, $version, $repoRoot, $pkgDir, $gitLock)

    $current_version = get-current-version
    Write-Output "current version: <$current_version>"
    Write-Output "latest version: <$version>"
    $HAS_NEW_VERSION = ("$current_version" -ne "$version")

    # validate version format
    if (-not ($version -cmatch '^(0|[1-9]\d*)(\.(0|[1-9]\d*))*$'))
    {
        Write-Output "::error ::Invalid version format"
        add-summary-row "|$pkg_name|$current_version|$version|🔴 Invalid Version |"
        if ($env:WORKFLOW_NAME -ne "update")
        {
            Write-Output "::fail::"
        }
        return
    }

    if (-not $HAS_NEW_VERSION)
    {
        add-summary-row "|$pkg_name|$current_version |🔵 Already up-to-date|"
        return
    }
    # skip if remote branch already exists
    $update_branch = "update/$pkg_name"
    $remoteExists = git ls-remote --heads origin $update_branch
    if ($remoteExists)
    {
        add-summary-row "|$pkg_name|$current_version -> $version|🟡 New version found, but remote branch already exists|"
        return
    }

    # Per-package scratch dir (outside the worktree so `git add -A` can't pick it up)
    $tmpRoot = Join-Path ([IO.Path]::GetTempPath()) "update-$pkg_name-$PID"
    New-Item -ItemType Directory -Force $tmpRoot | Out-Null
    $changelogFile = Join-Path $tmpRoot "changelog.md"
    $wt = Join-Path $tmpRoot "wt"

    # Get changelog
    $changelog = ""
    $code = & yq -r '.extra.changelog' recipe.yaml
    if ($code -ne "null")
    {
        $code = $code -replace "`r?`n", "`n"
        $changelog = & ([ScriptBlock]::Create(($code -join "`n")))
    }
    $changelog > $changelogFile

    # Isolated worktree on a new branch (replaces checkout -b / checkout back / reset / clean)
    [Threading.Monitor]::Enter($gitLock)
    try
    {
        git -C $repoRoot worktree add -b $update_branch $wt HEAD
    } finally
    {
        [Threading.Monitor]::Exit($gitLock)
    }

    try
    {
        $rel = [IO.Path]::GetRelativePath($repoRoot, $pkgDir)
        $recipe = Join-Path (Join-Path $wt $rel) "recipe.yaml"

        # Update version number and reset build number
        Write-Output "New version found. Updating $pkg_name/recipe.yaml"
        (Get-Content -Path $recipe) -replace '^  version: "[\d\.]+"', "  version: ""$version""" | Set-Content -Path $recipe
        (Get-Content -Path $recipe) -replace '  number: \d+', "  number: 0" | Set-Content -Path $recipe

        # create pr
        Write-Output "creating new branch: $pkg_name"
        git -C $wt add -A
        git -C $wt commit -m "chore: update ``$pkg_name`` from ``$current_version`` to ``$version``"
        git -C $wt push -u origin $update_branch
        Push-Location $wt
        try
        {
            $pr_url = gh pr create `
                --title "chore: update ``$pkg_name`` from ``$current_version`` to ``$version``" `
                --body-file $changelogFile `
                --base main `
                --head $update_branch
        } finally
        {
            Pop-Location
        }
        add-summary-row "| $pkg_name | $current_version -> ✨ **$version** | 🟢 [PR]($pr_url) created |"
    } finally
    {
        [Threading.Monitor]::Enter($gitLock)
        try
        {
            git -C $repoRoot worktree remove --force $wt
            git -C $repoRoot branch -D $update_branch
        } finally
        {
            [Threading.Monitor]::Exit($gitLock)
        }
        Remove-Item $tmpRoot -Recurse -Force -ErrorAction SilentlyContinue
    }
}

# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------
$repoRoot = (Resolve-Path "$PSScriptRoot/../..").Path
$pkgRoot = (Resolve-Path "$PSScriptRoot/../packages").Path

# Global git identity: set once, not per package
git config --global user.name "github-actions[bot]"
git config --global user.email "41898282+github-actions[bot]@users.noreply.github.com"

# Functions don't exist in -Parallel runspaces; ship their definitions over
$helperNames = 'get-current-version', 'get-version-github', 'get-version-conda-forge',
'get-version-crateio', 'get-version-winget', 'get-version-url', 'get-version-text',
'get-changelog-github', 'add-summary-row', 'update-recipe'
$funcDefs = ($helperNames | ForEach-Object {
        "function $_ {`n$((Get-Item "function:$_").ScriptBlock)`n}"
    }) -join "`n"

$gitLock = [object]::new()

$jobs = @()
$index = 0
ForEach ($Row in Import-Csv $PSScriptRoot/../packages.csv)
{
    if ($Row.pkg.StartsWith("_"))
    {
        continue
    }
    $jobs += [pscustomobject]@{ Index = $index++; Pkg = $Row.pkg }
}

$results = $jobs | ForEach-Object -ThrottleLimit $ThrottleLimit -Parallel {
    $job = $_
    . ([scriptblock]::Create($using:funcDefs))
    $repoRoot = $using:repoRoot
    $gitLock = $using:gitLock
    $pkgDir = Join-Path $using:pkgRoot $job.Pkg

    # Capture every stream so the log can be replayed as one ordered group
    $lines = & {
        try
        {
            Set-Location $pkgDir
            $code = & yq -r '.extra.update' recipe.yaml
            $code = $code -replace "`r?`n", "`n"
            $latest_version = & ([ScriptBlock]::Create(($code -join "`n")))
            update-recipe $job.Pkg $latest_version $repoRoot $pkgDir $gitLock
        } catch
        {
            Write-Output "::error ::$($_.Exception.Message)"
            Write-Output "::row::| $($job.Pkg) | | 🔴 Failed: $($_.Exception.Message -replace '\|','/' -replace '\r?\n',' ') |"
            Write-Output "::fail::"
        }
    } *>&1 | ForEach-Object { "$_" }

    [pscustomobject]@{ Index = $job.Index; Pkg = $job.Pkg; Lines = @($lines) }
}

# Replay in original order: groups + summary table
"| Package | Version | Status |" >> $env:GITHUB_STEP_SUMMARY
"|---|---|---|" >> $env:GITHUB_STEP_SUMMARY
$failed = $false
foreach ($r in ($results | Sort-Object Index))
{
    Write-Output "::group::update $($r.Pkg)"
    foreach ($line in $r.Lines)
    {
        if ($line.StartsWith("::row::"))
        {
            $line.Substring(7) >> $env:GITHUB_STEP_SUMMARY
        } elseif ($line -eq "::fail::")
        {
            $failed = $true
        } else
        {
            Write-Output $line
        }
    }
    Write-Output "::endgroup::"
}
if ($failed)
{
    exit 1
}
