Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

& $PSScriptRoot/../libraw_build/vcpkg-setup.ps1
& $PSScriptRoot/../libraw_build/vcpkg-install.ps1

Set-Location $PSScriptRoot
build-pkg
