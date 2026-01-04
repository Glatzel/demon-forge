Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

Set-Location $env:SRC_DIR
& ./scripts/setup.ps1
Set-Location ./crates/fornax-py
pixi run maturin build --out ./dist --profile release
foreach ($whl in Get-ChildItem "./dist/*.whl") {
    pip install "$whl" -v
}
