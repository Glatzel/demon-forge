Set-Location python
$env:MACOSX_DEPLOYMENT_TARGET = 15.0
maturin build --out ./dist --profile release
foreach ($whl in Get-ChildItem "./dist/*.whl") {
    pip install "$whl" -v
}
