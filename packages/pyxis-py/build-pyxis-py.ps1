Set-Location python
maturin build --out ./dist --profile release
foreach ($whl in Get-ChildItem "./dist/*.whl") {
    pip install "$whl" -v
}
