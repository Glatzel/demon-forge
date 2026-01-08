Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
$latest_version = get-version-github -repo "tsl0922/$name"
update-recipe -version $latest_version
build-pkg
$env:TARGET_PLATFORM = "win-64"
build-pkg -target_platform "win-64"
