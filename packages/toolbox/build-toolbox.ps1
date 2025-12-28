Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

Set-Location $ROOT/temp/$name/$name
pip install . -v
