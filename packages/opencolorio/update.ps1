Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
$latest_version = get-version-github -repo "AcademySoftwareFoundation/OpenColorIO"
update-recipe $latest_version
