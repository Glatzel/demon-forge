$env:PROJ_ROOT = "$(Resolve-Path ./)"
Set-Location rust
cargo install --bin pyxis --root $env:PREFIX --path ./crates/pyxis-cli
