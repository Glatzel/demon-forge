Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

if ($IsMacOS) { $mac_suffix = "_mac" }
& $PSScriptRoot/../libraw_build$mac_suffix/vcpkg-setup.ps1
& $PSScriptRoot/../libraw_build$mac_suffix/vcpkg-install.ps1

Set-Location $PSScriptRoot
build-pkg
