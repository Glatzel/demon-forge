$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1



& ./scripts/setup.ps1
Set-Location ./crates/fornax-py
pixi run maturin build --out ./dist --profile release
foreach ($whl in Get-ChildItem "./dist/*.whl") {
    pip install "$whl" -v
}
