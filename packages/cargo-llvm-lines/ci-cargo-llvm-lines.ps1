Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

$latest_version = get-latest-version -repo "dtolnay/$name"
$latest_version = "$latest_version".Replace("v", "")
update-recipe -version $latest_version

cargo install $name --root $ROOT/temp/$name
build-pkg
