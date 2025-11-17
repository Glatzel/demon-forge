# Get the root directory of the current Git repository
$ROOT = git rev-parse --show-toplevel

# Configure PYTHONPATH differently depending on the platform
if ($IsWindows) {
    # On Windows, use semicolon as path separator
    $env:PYTHONPATH = "$ROOT;$env:PYTHONPATH"
}
else {
    # On Unix-like systems, use colon as path separator
    $env:PYTHONPATH = $ROOT + ':' + "$env:PYTHONPATH"
}

# Stop execution on any error and propagate native command errors
$ErrorActionPreference = "Stop"
$PSNativeCommandUseErrorActionPreference = $true

# Function: Extract the current version from recipe.yaml
function get-current-version {
    $matched = Select-String -Path "./recipe.yaml" -Pattern '^  version: (\S+)'
    $v = $matched.Matches[0].Groups[1]
    $v = "$v".Replace("""", "")
    Write-Output $v
}

# Function: Extract the package name from recipe.yaml
function get-name {
    $matched = Select-String -Path "./recipe.yaml" -Pattern '^  name: (\w+\S+)'
    Write-Output $matched.Matches[0].Groups[1]
}

# Function: Get the latest release tag from a GitHub repository
function get-version-github {
    param($repo)
    gh release view -R $repo --json tagName -q .tagName
}
function get-version-crateio {
    param($name)
    if ($IsLinux) {
        sudo apt update && sudo apt install ca-certificates
        sudo update-ca-certificates
    }
    curl -sL https://crates.io/api/v1/crates/$name | jq -r  '.crate.max_version'
}
# Function: Update the recipe.yaml file if a new version is detected
function update-recipe {
    param($version)
    $cversion = get-current-version
    Write-Output "current version: <$cversion>"
    Write-Output "latest version: <$version>"
    $HAS_NEW_VERSION = ("$cversion" -ne "$version") -and ($version)
    if ($HAS_NEW_VERSION) {
        Write-Output "::group::update recipe"
        Write-Output "New version found."
        # Update version number and reset build number
        (Get-Content -Path "./recipe.yaml") -replace '^  version: .*', "  version: ""$version""" | Set-Content -Path "./recipe.yaml"
        (Get-Content -Path "./recipe.yaml") -replace '^  number: .*', "  number: 0" | Set-Content -Path "./recipe.yaml"
        if ($env:CI) {
            "latest-version=$version" >> $env:GITHUB_OUTPUT
            "current-version=$cversion" >> $env:GITHUB_OUTPUT
        }
        Write-Output "::endgroup::"
    }
    if ($env:CI) {
        switch ($true ) {
            { $HAS_NEW_VERSION -and ( $env:GITHUB_EVENT_NAME -eq "workflow_dispatch" ) -and ($env:GITHUB_REF_NAME -eq "main") } { "action_pr=true" >> $env:GITHUB_OUTPUT; exit 0 }

            { $HAS_NEW_VERSION -and $env:GITHUB_EVENT_NAME -eq "push" } { "action_pr=true" >> $env:GITHUB_OUTPUT; exit 0 }
            { (-not $HAS_NEW_VERSION) -and ($env:GITHUB_EVENT_NAME -eq "push" ) -and ($env:GITHUB_REF_NAME -eq "main") } { $env:NEED_BUILD = $true; "action_publish=true" >> $env:GITHUB_OUTPUT }

            { $env:GITHUB_EVENT_NAME -eq "pull_request" } { Write-Output "need build in pr." }

            { $HAS_NEW_VERSION -and $env:GITHUB_EVENT_NAME -eq "schedule" } { "action_pr=true" >> $env:GITHUB_OUTPUT; exit 0 }
            default { exit 0 }
        }
    }
}

# Function: Reset build number in recipe.yaml to 0
function reset-build-code {
    (Get-Content -Path "./recipe.yaml") -replace '^  number: .*', "  number: 0" | Set-Content -Path "./recipe.yaml"
}

# Function: Build the package using rattler-build inside Pixi
function build-pkg {
    Write-Output "::group::build"
    pixi run rattler-build build
    Write-Output "::endgroup::"
}

# Extract package name and current system architecture
$name = get-name
# Possible values:
# - X86 (32-bit)
# - X64 (64-bit)
# - Arm (ARM 32-bit)
# - Arm64 (ARM 64-bit)
$arch = [System.Runtime.InteropServices.RuntimeInformation]::OSArchitecture
