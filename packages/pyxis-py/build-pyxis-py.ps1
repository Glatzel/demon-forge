$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

/python
pixi run maturin build --out ./dist --profile release
foreach ($whl in Get-ChildItem "./dist/*.whl") {
    pip install "$whl" -v
}
