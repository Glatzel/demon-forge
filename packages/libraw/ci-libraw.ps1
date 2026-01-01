Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
$latest_version = get-version-github -repo "LibRaw/LibRaw"
update-recipe -version $latest_version
Set-Location $PSScriptRoot
build-pkg
