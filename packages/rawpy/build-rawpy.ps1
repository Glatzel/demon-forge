Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
$name = get-name

$whl=(Get-ChildItem "$ROOT/temp/${name}/$name*.whl")[0]
pip install "$whl" -v

$helper=Resolve-Path "$PSScriptRoot/../${name}_helper/"
pip install "$helper" -v
