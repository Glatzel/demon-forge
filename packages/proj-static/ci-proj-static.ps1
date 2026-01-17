Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
$latest_version = get-version-vcpkg -name proj
update-recipe -version $latest_version
update-vcpkg-json -file $PSScriptRoot/build/vcpkg.json -name proj -version $latest_version
Set-Location $PSScriptRoot
build-pkg
