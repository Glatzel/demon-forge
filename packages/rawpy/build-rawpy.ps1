Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
$name = get-name

$whl=(Get-ChildItem "$PSScriptRoot/../${name}_build/$name/dist/*.whl")[0]
pip install "$whl" -v
