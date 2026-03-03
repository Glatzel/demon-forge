Set-Location rust
if ($IsWindows) {
    $env:PROJ_ROOT = "$(Resolve-Path ../)"
}
else {
    $env:PROJ_ROOT = "$(Resolve-Path ../)"
}
cargo install --bin pyxis --root $env:PREFIX --path ./crates/pyxis-cli
