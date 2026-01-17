Set-Location rust
if ($IsWindows) {
    $env:PROJ_ROOT = "$(Resolve-Path $env:BUILD_PREFIX/Library)"
}
else {
    $env:PROJ_ROOT = "$(Resolve-Path $env:BUILD_PREFIX)"
}
cargo install --bin pyxis --root $env:PREFIX --path ./crates/pyxis-cli
