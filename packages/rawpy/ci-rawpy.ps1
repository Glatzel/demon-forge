Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

# process version
$current_version = get-current-version
Write-Output "Current Version: $current_version"
$rawpy_version = get-latest-version -repo "letmaik/rawpy"
$rawpy_version ="$rawpy_version".Replace("v","")
$libraw_version = get-latest-version -repo "LibRaw/LibRaw"
Write-Output "rawpy: $rawpy_version"
Write-Output "libraw: $libraw_version"
update-recipe -version $rawpy_version
(Get-Content -Path "./recipe.yaml") -replace '^  libraw-version: .*', "  libraw-version: $libraw_version" | Set-Content -Path "./recipe.yaml"
# #pre-build
# & $PSScriptRoot/../$name_build/scripts/build_$name.ps1

# #rattler build
# Set-Location $PSScriptRoot

# build-pkg
