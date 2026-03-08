Set-Location rust
if ($IsWindows) {
    $env:PROJ_ROOT = "$(Resolve-Path ../h_env/Library)"
}
else {
    $env:PROJ_ROOT = "$(Resolve-Path ../h_env)"
}
cargo install --bin pyxis --root $env:PREFIX --path ./crates/pyxis-cli
