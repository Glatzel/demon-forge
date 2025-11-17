Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

$latest_version = curl -s https://crates.io/api/v1/crates/$name | jq '.crate.max_version'
build-pkg
