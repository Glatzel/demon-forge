Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
$latest_version = get-version-github "EdJoPaTo/$name"
update-recipe -version $latest_version
build-pkg
