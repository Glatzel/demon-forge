if ($IsWindows) {
    $env:PROJ_ROOT = "$(Resolve-Path $SRC_DIR/../h_env/Library)"
}
else {
    $env:PROJ_ROOT = "$(Resolve-Path $SRC_DIR/../h_env)"
}
Set-Location rust
cargo install --bin pyxis --root $env:PREFIX --path ./crates/pyxis-cli
