if ($IsWindows) {
    $env:PROJ_ROOT = "$(Resolve-Path ../h_env/Library)"
}
else {
    $env:PROJ_ROOT = "$(Resolve-Path ../h_env)"
}
Set-Location rust
cargo install --bin pyxis --root $env:PREFIX --path ./crates/pyxis-cli
