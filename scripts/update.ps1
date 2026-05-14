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
    param($repo)
    gh release view $tag -R $repo --json body | jq -r '.body'
}
function update-recipe
{
    param($name, $version)

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
            "|$name|$current_version|$version|🔴 Invalid Version |" >> $env:GITHUB_STEP_SUMMARY
            return
        } else
        {
            exit 1
        }
    }

    if (-not $HAS_NEW_VERSION)
    {
        "|$name|$current_version|$version|🔵 No new version found|" >> $env:GITHUB_STEP_SUMMARY
        return
    }
    # skip if remote branch already exists
    $update_branch = "update/$name"
    $remoteExists = git ls-remote --heads origin $update_branch
    if ($remoteExists)
    {
        "|$name|$current_version|$version|🟡 New version found, but remote branch already exists|" >> $env:GITHUB_STEP_SUMMARY
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

    # Update version number and reset build number
    $originalBranch = git rev-parse --abbrev-ref HEAD
    git checkout -b $update_branch
    Write-Output "New version found. Updating $name/recipe.yaml"
    (Get-Content -Path "./recipe.yaml") -replace '^  version: "[\d\.]+"', "  version: ""$version""" | Set-Content -Path "./recipe.yaml"
    (Get-Content -Path "./recipe.yaml") -replace '  number: \d+', "  number: 0" | Set-Content -Path "./recipe.yaml"

    # create pr
    Write-Output "creating new branch: $name"
    git config --global user.name "github-actions[bot]"
    git config --global user.email "41898282+github-actions[bot]@users.noreply.github.com"
    git add -A
    git commit -m "chore: update ``$name`` from ``$current_version`` to ``$version``"
    git push -u origin $update_branch
    $pr_url = gh pr create `
        --title "chore: update ``$name`` from ``$current_version`` to ``$version``" `
        --body "$changelog" `
        --base main `
        --head $update_branch `
        --draft
    git checkout $originalBranch
    git reset --hard
    git clean -fd
    "| $name | $current_version | ✨ **$version** | 🟢 [PR]($pr_url) created |" >> $env:GITHUB_STEP_SUMMARY
    return
}

"| Package | Current Version | Latest Version | Status |" >> $env:GITHUB_STEP_SUMMARY
"|---|---|---|---|" >> $env:GITHUB_STEP_SUMMARY
ForEach ($name in get-childitem $PSScriptRoot/../packages)
{
    $name=$name.Name
    Write-Output "::group::update $name"
    Set-Location "$PSScriptRoot/../packages/$name"
    $code = & yq -r '.extra.update' recipe.yaml
    $code = $code -replace "`r?`n", "`n"
    $latest_version = & ([ScriptBlock]::Create(($code -join "`n")))
    update-recipe $name $latest_version
    Write-Output "::endgroup::"
}
