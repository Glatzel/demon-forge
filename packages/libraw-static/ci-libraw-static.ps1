Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
$latest_version = get-version-vcpkg -name libraw
update-recipe -version $latest_version
update-vcpkg-json -file $PSScriptRoot/build/vcpkg.json -name libraw -version $latest_version
build-pkg
