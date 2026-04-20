# Get the root directory of the current Git repository
$ROOT = git rev-parse --show-toplevel
$ErrorActionPreference = "Stop"
$PSNativeCommandUseErrorActionPreference = $true
Remove-Item Alias:curl -ErrorAction SilentlyContinue

# avoid build error by long path
if ($IsWindows)
{
    # avoid build error by long path
    if ($env:CI)
    {
        $env:CARGO_TARGET_DIR = "c:/t"
        $env:CARGO_HOME = "c:/c"
    }
}

# Function: Extract the current version from recipe.yaml
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

function Get-Cargo-Arg
{
    $cargo_arg = @(
        '--root', "$env:PREFIX"
        '--locked'
        '--force'
        '--config'
        'profile.release.debug=false'
        '--config', 'profile.release.codegen-units=1'
        '--config', 'profile.release.lto="fat"'
        '--config', 'profile.release.opt-level=3'
        '--config', 'profile.release.strip=true'
    )

    return $cargo_arg
}
function get-name
{
    $matched = Select-String -Path "./recipe.yaml" -Pattern '^  name: (\w+\S+)'
    Write-Output $matched.Matches[0].Groups[1]
}
function update-recipe
{
    param($version)

    $name = get-name
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
    $update_branch = "update-$name"
    $remoteExists = git ls-remote --heads origin $update_branch
    if ($remoteExists)
    {
        "|$name|$current_version|$version|🟡 New version found, but remote branch already exists|" >> $env:GITHUB_STEP_SUMMARY
        return
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
        --body "" `
        --base main `
        --head $update_branch `
        --draft
    git checkout $originalBranch
    git reset --hard
    git clean -fd
    "| $name | $current_version | ✨ **$version** | 🟢 [PR]($pr_url) created |" >> $env:GITHUB_STEP_SUMMARY
    return
}

function build-recipe
{
    if ($env:CI -and ($env:GITHUB_EVENT_NAME -eq "push"))
    { "action_publish=true" >> $env:GITHUB_OUTPUT
    }
    Write-Output "::group:: build $pkg"
    $rattler_build_args = @(
        "--config-file", "$ROOT/rattler-config.toml"
        "--color", "always"
        "build", "--output-dir", "$ROOT/output"
        "--variant-config", "$ROOT/conda_build_config.yaml"
        "--env-isolation", "none"
        "--experimental"
    )
    if ($env:CI -and ($env:TARGET_PLATFORM -ne "noarch"))
    {
        $rattler_build_args += ("--target-platform", "$env:TARGET_PLATFORM")
    }
    if ($env:GITHUB_EVENT_NAME -eq "push")
    {
        $rattler_build_args += ("--package-format", "conda:22")
    } else
    {
        $rattler_build_args += ("--package-format", "conda:-7")
    }
    pixi run rattler-build $rattler_build_args
    Write-Output "::endgroup::"
    foreach ($pkg_file in Get-ChildItem "$ROOT/output/$env:TARGET_PLATFORM/$(get-name)-*.conda")
    {
        Write-Output "::group:: inspect $pkg"
        pixi run rattler-build package inspect --all $pkg_file
        Write-Output "::endgroup::"
    }
}
