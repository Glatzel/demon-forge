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
function update-recipe
{
    param($pkg_name, $version)

    $current_version = get-current-version
    Write-Output "current version: <$current_version>"
    Write-Output "latest version: <$version>"
    $HAS_NEW_VERSION = ("$current_version" -ne "$version")

    # validate version format
    if (-not ($version -cmatch '^(0|[1-9]\d*)(\.(0|[1-9]\d*))*$'))
    {
        Write-Output "::error ::Invalid version format"
        if ($env:WORKFLOW_NAME -eq "update")
        {
            "|$pkg_name|$current_version|$version|🔴 Invalid Version |" >> $env:GITHUB_STEP_SUMMARY
            return
        } else
        {
            exit 1
        }
    }

    if (-not $HAS_NEW_VERSION)
    {
        "|$pkg_name|$current_version |🔵 Already up-to-date|" >> $env:GITHUB_STEP_SUMMARY
        return
    }
    # skip if remote branch already exists
    $update_branch = "update/$pkg_name"
    $remoteExists = git ls-remote --heads origin $update_branch
    if ($remoteExists)
    {
        "|$pkg_name|$current_version -> $version|🟡 New version found, but remote branch already exists|" >> $env:GITHUB_STEP_SUMMARY
        return
    }

    # Get changelog
    $changelog = ""
    $code = & yq -r '.extra.changelog' recipe.yaml
    if ($code -ne "null")
    {
        $code = $code -replace "`r?`n", "`n"
        $changelog = & ([ScriptBlock]::Create(($code -join "`n")))
    }
    $changelog > $PSScriptRoot/../../changelog.md

    # Update version number and reset build number
    $originalBranch = git rev-parse --abbrev-ref HEAD
    git checkout -b $update_branch
    Write-Output "New version found. Updating $pkg_name/recipe.yaml"
    (Get-Content -Path "./recipe.yaml") -replace '^  version: "[\d\.]+"', "  version: ""$version""" | Set-Content -Path "./recipe.yaml"
    (Get-Content -Path "./recipe.yaml") -replace '  number: \d+', "  number: 0" | Set-Content -Path "./recipe.yaml"

    # create pr
    Write-Output "creating new branch: $pkg_name"
    git config --global user.name "github-actions[bot]"
    git config --global user.email "41898282+github-actions[bot]@users.noreply.github.com"
    git add -A
    git commit -m "chore: update ``$pkg_name`` from ``$current_version`` to ``$version``"
    git push -u origin $update_branch
    $pr_url = gh pr create `
        --title "chore: update ``$pkg_name`` from ``$current_version`` to ``$version``" `
        --body-file "$PSScriptRoot/../../changelog.md" `
        --base main `
        --head $update_branch
    git checkout $originalBranch
    git reset --hard
    git clean -fd
    "| $pkg_name | $current_version -> ✨ **$version** | 🟢 [PR]($pr_url) created |" >> $env:GITHUB_STEP_SUMMARY
    return
}

"| Package | Version | Status |" >> $env:GITHUB_STEP_SUMMARY
"|---|---|---|" >> $env:GITHUB_STEP_SUMMARY
ForEach ($Row in Import-Csv $PSScriptRoot/../packages.csv)
{
    $pkg_name=$Row.pkg
    if($pkg_name.StartsWith("_"))
    {
        continue
    }
    Write-Output "::group::update $pkg_name"
    Set-Location "$PSScriptRoot/../packages/$pkg_name"
    $code = & yq -r '.extra.update' recipe.yaml
    $code = $code -replace "`r?`n", "`n"
    $latest_version = & ([ScriptBlock]::Create(($code -join "`n")))
    update-recipe $pkg_name $latest_version
    Write-Output "::endgroup::"
}
