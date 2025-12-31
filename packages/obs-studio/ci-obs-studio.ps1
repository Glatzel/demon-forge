Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
$latest_version = get-version-github -repo "https://github.com/obsproject/$name"
update-recipe -version $latest_version
build-pkg
