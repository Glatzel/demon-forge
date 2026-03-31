Set-Location rust
$env:PROJ_ROOT = "$(Resolve-Path $env:BUILD_PREFIX/Library)"
cargo install --bin pyxis --root $env:PREFIX --path ./crates/pyxis-cli
