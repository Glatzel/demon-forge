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
    $version = gh release view -R $repo --json tagName -q .tagName
    $version = "$version".Replace("v", "")
    return $version
}
function get-version-crateio {
    param($name)
    (cargo search $name | Select-String -Pattern "^$name = ""\d" | ForEach-Object {
        ($_ -split '"')[1]
    })
}
function get-version-vcpkg {
    param($name)
    curl -s https://raw.githubusercontent.com/microsoft/vcpkg/master/ports/$name/vcpkg.json | `
        jq -r '( .["version-string"] // .version // .["version-semver"] // .["version-date"] )'
}
function get-version-url {
    param($url, $pattern)
    for ($i = 0; $i -lt 5; $i++) {
        $html = curl -sL $url
        $versions = [regex]::Matches($html, $pattern) | `
            ForEach-Object { $_.Groups[1].Value }
        $latest = $versions | `
            Sort-Object { [version]$_ } -Descending | `
            Select-Object -First 1
        if ($latest) {
            return $latest
        }
    }
}
function update-vcpkg-json {
    param($file, $name, $version)
    $json = Get-Content $file -Raw | ConvertFrom-Json

    # update the override
    $json.overrides | Where-Object { $_.name -eq "$name" } | ForEach-Object {
        $_.version = $version
    }

    # save formatted JSON
    $json | ConvertTo-Json -Depth 10 | Set-Content $file
}
# Function: Update the recipe.yaml file if a new version is detected
function update-recipe {
    param($version)
    $current_version = get-current-version
    Write-Output "current version: <$current_version>"
    Write-Output "latest version: <$version>"
    if (-not ($version -cmatch '^\d+(\.\d+)+$')) {
        throw "Invalid version"
    }
    $HAS_NEW_VERSION = ("$current_version" -ne "$version")
    if ($HAS_NEW_VERSION) {
        Write-Output "::group::update recipe"
        Write-Output "New version found."
        # Update version number and reset build number
        (Get-Content -Path "./recipe.yaml") -replace '^  version: .*', "  version: ""$version""" | Set-Content -Path "./recipe.yaml"
        (Get-Content -Path "./recipe.yaml") -replace '^  number: .*', "  number: 0" | Set-Content -Path "./recipe.yaml"
        if ($env:CI) {
            "latest-version=$version" >> $env:GITHUB_OUTPUT
            "current-version=$current_version" >> $env:GITHUB_OUTPUT
        }
        Write-Output "::endgroup::"
    }
    if ($env:CI) {
        switch ($true ) {
            { $HAS_NEW_VERSION -and ( $env:GITHUB_EVENT_NAME -eq "workflow_dispatch" ) -and ($env:GITHUB_REF_NAME -eq "main") } { "action_pr=true" >> $env:GITHUB_OUTPUT; exit 0 }

            { $HAS_NEW_VERSION -and $env:GITHUB_EVENT_NAME -eq "push" } { "action_pr=true" >> $env:GITHUB_OUTPUT; exit 0 }
            { (-not $HAS_NEW_VERSION) -and ($env:GITHUB_EVENT_NAME -eq "push" ) -and ($env:GITHUB_REF_NAME -eq "main") } { "action_publish=true" >> $env:GITHUB_OUTPUT }

            { $env:GITHUB_EVENT_NAME -eq "pull_request" } { }

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
function create-temp {
    param( $name)
    Remove-Item $ROOT/temp/$name -Recurse -ErrorAction SilentlyContinue
    New-Item  $ROOT/temp/$name -ItemType Directory
}
# Extract package name and current system architecture
$name = get-name
create-temp -name $name
# Possible values:
# - X86 (32-bit)
# - X64 (64-bit)
# - Arm (ARM 32-bit)
# - Arm64 (ARM 64-bit)
$arch = [System.Runtime.InteropServices.RuntimeInformation]::OSArchitecture
