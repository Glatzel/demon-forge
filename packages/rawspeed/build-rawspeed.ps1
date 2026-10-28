Set-Location $env:RECIPE_DIR
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
Set-Location $env:SRC_DIR
cmake-build
