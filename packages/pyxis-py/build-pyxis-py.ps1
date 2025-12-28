Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

foreach ($whl in Get-ChildItem "$ROOT/temp/$name/pyxis/python/dist/*.whl") {
    pip install "$whl" -v
}
