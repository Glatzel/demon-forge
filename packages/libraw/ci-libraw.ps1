Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

$latest_version = get-version-vcpkg -name $name
update-recipe -version $latest_version
update-vcpkg-json -file $PSScriptRoot/../$name_build/vcpkg.json -name $name -version $latest_version
& $PSScriptRoot/../$name_build/vcpkg-setup.ps1
& $PSScriptRoot/../$name_build/vcpkg-update-baseline.ps1
& $PSScriptRoot/../$name_build/vcpkg-install.ps1

Set-Location $PSScriptRoot
build-pkg
