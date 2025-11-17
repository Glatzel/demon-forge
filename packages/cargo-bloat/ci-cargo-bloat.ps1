Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

$latest_version = curl -s https://crates.io/api/v1/crates/$name | jq -r '.crate.max_version'
update-recipe -version $latest_version

cargo install $name --root $ROOT/temp/$name --force

build-pkg
