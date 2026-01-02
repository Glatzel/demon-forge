Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
$latest_version = get-version-github -repo "AcademySoftwareFoundation/OpenImageIO"
update-recipe -version $latest_version
build-pkg
