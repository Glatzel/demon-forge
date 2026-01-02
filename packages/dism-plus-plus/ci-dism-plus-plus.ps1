Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

$latest_version = get-version-github -repo "Chuyu-Team/Dism-Multi-language"
update-recipe -version $latest_version
build-pkg
