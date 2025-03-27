param($version)
Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
$name = get-name

$whl=Resolve-Path $PSScriptRoot/../$name_build/$name/dist/$name-$version-cp311-cp311-win_amd64.whl
pip install "$whl" -v
