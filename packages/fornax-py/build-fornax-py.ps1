$env:MACOSX_DEPLOYMENT_TARGET = "14.0"
if ($IsWindows) {
    $env:LIBRAW_ROOT = "$(Resolve-Path $env:BUILD_PREFIX/Library)"
}
else {
    $env:LIBRAW_ROOT = "$(Resolve-Path $env:BUILD_PREFIX)"
}
Set-Location ./crates/fornax-py
pixi run maturin build --out ./dist --profile release
foreach ($whl in Get-ChildItem "./dist/*.whl") {
    pip install "$whl" -v
}
