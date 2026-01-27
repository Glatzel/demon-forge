# Get the root directory of the current Git repository
$ROOT = git rev-parse --show-toplevel
$ErrorActionPreference = "Stop"
$PSNativeCommandUseErrorActionPreference = $true
Remove-Item Alias:curl -ErrorAction SilentlyContinue
# Configure PYTHONPATH differently depending on the platform
if ($IsWindows) {
    # On Windows, use semicolon as path separator
    $env:PYTHONPATH = "$ROOT;$env:PYTHONPATH"
}
if ($IsMacOS) {
    # On Unix-like systems, use colon as path separator
    $env:PYTHONPATH = $ROOT + ':' + "$env:PYTHONPATH"
}
if ($IsLinux) {
    # On Unix-like systems, use colon as path separator
    $env:PYTHONPATH = $ROOT + ':' + "$env:PYTHONPATH"
}

# Function: Extract the current version from recipe.yaml
function get-current-version {
    $matched = Select-String -Path "./recipe.yaml" -Pattern '^  version: (\S+)'
    $v = $matched.Matches[0].Groups[1]
    $v = "$v".Replace("""", "")
    Write-Output $v
}

# Function: Extract the package name from recipe.yaml
function get-name {
    if ($env:PKG_NAME) {
        return $env:PKG_NAME
    }
    else {
        $matched = Select-String -Path "./recipe.yaml" -Pattern '^  name: (\w+\S+)'
        Write-Output $matched.Matches[0].Groups[1]
    }
}

# Function: Get the latest release tag from a GitHub repository
function get-version-github {
    param($repo)for ($i = 0; $i -lt 5; $i++) {
        $latest = gh release view -R $repo --json tagName -q .tagName
        $latest = "$latest".Replace("v", "")
        if ($latest) {
            return $latest
        }
    }
}
function get-version-crateio {
    param($name)
    for ($i = 0; $i -lt 5; $i++) {
        $latest = curl -s -H "User-Agent: gh-actions-ci" https://crates.io/api/v1/crates/$name | jq -r '.crate.max_version'
        if ($latest) {
            return $latest
        }
    }
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
function get-version-text {
    param($text, $pattern)

    $versions = [regex]::Matches($text, $pattern) | `
        ForEach-Object { $_.Groups[1].Value }
    $latest = $versions | `
        Sort-Object { [version]$_ } -Descending | `
        Select-Object -First 1
    return $latest
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
function Get-Cargo-Arg {
    $cargo_arg = @(
        '--root', "$env:PREFIX"
        '--locked'
        '--force'
        '--config'
        'profile.release.debug=false'
    )
    if ($env:GITHUB_REF_NAME -eq "main") {
        $cargo_arg += @(
            '--config', 'profile.release.codegen-units=1'
            '--config', 'profile.release.lto="fat"'
            '--config', 'profile.release.opt-level=3'
            '--config', 'profile.release.strip=true'
        )
    }
    else {
        $cargo_arg += @(
           
            '--config', 'profile.release.opt-level=2'
            '--config', 'profile.release.lto="thin"'
            '--config', 'profile.release.codegen-units=256'
            '--config', 'profile.release.strip=false'
        )
    }
    return 
}

# Function: Update the recipe.yaml file if a new version is detected
function update-recipe {
    param($version)
    $current_version = get-current-version
    Write-Output "current version: <$current_version>"
    Write-Output "latest version: <$version>"
    $HAS_NEW_VERSION = ("$current_version" -ne "$version")
    # update new version
    if ($HAS_NEW_VERSION -and (
            ($env:GITHUB_EVENT_NAME -eq "schedule") -or (
                ( $env:GITHUB_EVENT_NAME -eq "workflow_dispatch" ) -and ($env:GITHUB_REF_NAME -eq "main")
            )
        )
    ) {
        if (-not ($version -cmatch '^\d+(\.\d+)+$')) {
            throw "Invalid version"
        }
        Write-Output "::group::update recipe"
        Write-Output "New version found."
        # Update version number and reset build number
        (Get-Content -Path "./recipe.yaml") -replace '^  version: .*', "  version: ""$version""" | Set-Content -Path "./recipe.yaml"
        (Get-Content -Path "./recipe.yaml") -replace '^  number: .*', "  number: 0" | Set-Content -Path "./recipe.yaml"
        Write-Output "::endgroup::"
    }

    if ($env:CI) {
        "latest-version=$version" >> $env:GITHUB_OUTPUT
        "current-version=$current_version" >> $env:GITHUB_OUTPUT
        switch ($true ) {
            { $HAS_NEW_VERSION -and ( $env:GITHUB_EVENT_NAME -eq "workflow_dispatch" ) -and ($env:GITHUB_REF_NAME -eq "main") } { "action_pr=true" >> $env:GITHUB_OUTPUT; exit 0 }

            { $env:GITHUB_EVENT_NAME -eq "push" } { "action_publish=true" >> $env:GITHUB_OUTPUT; }

            { $env:GITHUB_EVENT_NAME -eq "pull_request" } { }

            { $HAS_NEW_VERSION -and $env:GITHUB_EVENT_NAME -eq "schedule" } { "action_pr=true" >> $env:GITHUB_OUTPUT; exit 0 }

            { $env:WORKFLOW_NAME -eq 'manual-build' } { }
            default { exit 0 }
        }
    }
    else { }
}

# Function: Reset build number in recipe.yaml to 0
function reset-build-code {
    (Get-Content -Path "./recipe.yaml") -replace '^  number: .*', "  number: 0" | Set-Content -Path "./recipe.yaml"
}

# Function: Build the package using rattler-build inside Pixi
function build-pkg {
    pixi run rattler-build `
        --config-file $ROOT/rattler-config.toml `
        --color always `
        build --output-dir $ROOT/output
}

# Extract package name and current system architecture
$name = get-name
# Possible values:
# - X86 (32-bit)
# - X64 (64-bit)
# - Arm (ARM 32-bit)
# - Arm64 (ARM 64-bit)
$arch = [System.Runtime.InteropServices.RuntimeInformation]::OSArchitecture
