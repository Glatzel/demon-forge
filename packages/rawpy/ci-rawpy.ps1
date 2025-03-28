Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
$name = get-name

# process version
$rawpy_version = get-latest-version -repo "letmaik/rawpy"
$rawpy_version ="$rawpy_version".Replace("v","")
Write-Output "rawpy: $rawpy_version"
Write-Output "libraw: $libraw_version"
$rawpy_version="$rawpy_version".Replace(".","_")

# #pre-build
& $PSScriptRoot/../${name}_build/scripts/build-$name.ps1

#rattler build
Set-Location $PSScriptRoot
update-recipe -version $rawpy_version
build-pkg
