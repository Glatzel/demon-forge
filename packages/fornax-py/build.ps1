if ($IsWindows) {
    $env:LIBRAW_ROOT = "$(Resolve-Path ../h_env/Library)"
}
else {
    $env:LIBRAW_ROOT = "$(Resolve-Path ../h_env)"
}
Set-Location ./crates/fornax-py
pixi run maturin build --out ./dist --profile release
foreach ($whl in Get-ChildItem "./dist/*.whl") {
    pip install "$whl" -v
}
