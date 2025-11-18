Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
$latest_version = get-version-vcpkg -name $name
update-recipe -version $latest_version
create-temp -name $name
update-vcpkg-json -file $PSScriptRoot/../libraw_build/vcpkg.json -name $name -version $latest_version
& $PSScriptRoot/../libraw_build/vcpkg-setup.ps1
& $PSScriptRoot/../libraw_build/vcpkg-install.ps1

Set-Location $PSScriptRoot
build-pkg
