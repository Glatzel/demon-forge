Set-Location rust
if ($IsWindows) {
    $env:PROJ_ROOT = "$(Resolve-Path $env:BUILD_PREFIX/Library)"
}
if ($IsMacOS) {
    $env:PROJ_ROOT = "$(Resolve-Path $env:BUILD_PREFIX)"
}
if ($IsLinux -and ($(uname -m) -eq 'x86_64' )) {
    $env:PROJ_ROOT = "$(Resolve-Path $env:BUILD_PREFIX)"
}
if ($IsLinux -and ($(uname -m) -eq 'aarch64' )) {
    $env:PROJ_ROOT = "$(Resolve-Path $env:BUILD_PREFIX)"
}
cargo install --bin pyxis --root $env:PREFIX --path ./crates/pyxis-cli
