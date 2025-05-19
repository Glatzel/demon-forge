Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

#pre-build
& $PSScriptRoot/../oiiotool_build/vcpkg-setup.ps1
& $PSScriptRoot/../oiiotool_build/vcpkg-install.ps1

#rattler build
Set-Location $PSScriptRoot
build-pkg
