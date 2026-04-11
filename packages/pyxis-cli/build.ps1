Set-Location rust
$env:PROJ_ROOT = "$(Resolve-Path $env:PREFIX/Library)"
cargo install --bin pyxis --root $env:PREFIX --path ./crates/pyxis-cli
