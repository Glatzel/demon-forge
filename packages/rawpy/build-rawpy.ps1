Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
$name = get-name

pip install "$ROOT/packages/${name}_build/mod" -v
Copy-Item "$ROOT/packages/${name}_build/mod/$name/*" $env:PREFIX/Lib/site-packages/rawpy