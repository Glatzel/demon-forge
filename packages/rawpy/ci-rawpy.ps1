Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
$name = get-name

# process version
$rawpy_version = get-latest-version -repo "letmaik/rawpy"
$rawpy_version ="$rawpy_version".Replace("v","")
$libraw_version = get-latest-version -repo "LibRaw/LibRaw"
Write-Output "rawpy: $rawpy_version"
Write-Output "libraw: $libraw_version"
$rawpy_version="$rawpy_version".Replace(".","_")
$libraw_version="$libraw_version".Replace(".","_")
(Get-Content -Path "./recipe.yaml") -replace '^  rawpy-version: .*', "  rawpy-version: '$rawpy_version'" | Set-Content -Path "./recipe.yaml"
(Get-Content -Path "./recipe.yaml") -replace '^  libraw-version: .*', "  libraw-version: '$libraw_version'" | Set-Content -Path "./recipe.yaml"

# #pre-build
& $PSScriptRoot/../${name}_build/scripts/build-$name.ps1

#rattler build
Set-Location $PSScriptRoot
build-pkg
