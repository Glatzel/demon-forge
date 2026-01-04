Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
Set-Location $env:SRC_DIR/rust
if ($IsLinux) {
    dnf update -y
    dnf install -y systemd-devel
    $env:PKG_CONFIG_PATH = "/usr/lib64/pkgconfig`:$env:PKG_CONFIG_PATH"
}
if ($IsWindows) {
    $env:PKG_CONFIG_PATH = "$(Resolve-Path $env:BUILD_PREFIX/proj/x64-windows-static/lib/pkgconfig);${env:PKG_CONFIG_PATH}"
}
if ($IsMacOS) {
    $env:PKG_CONFIG_PATH = "$(Resolve-Path $env:BUILD_PREFIX/proj/arm64-osx-release/lib/pkgconfig)`:${env:PKG_CONFIG_PATH}"
}
if ($IsLinux -and ($(uname -m) -eq 'x86_64' )) {
    $env:PKG_CONFIG_PATH = "$(Resolve-Path $env:BUILD_PREFIX/proj/x64-linux-release/lib/pkgconfig)`:/usr/lib/x86_64-linux-gnu/pkgconfig`:${env:PKG_CONFIG_PATH}"
}
if ($IsLinux -and ($(uname -m) -eq 'aarch64' )) {
    $env:PKG_CONFIG_PATH = "$(Resolve-Path $env:BUILD_PREFIX/proj/arm64-linux-release/lib/pkgconfig)`:/usr/lib/aarch64-linux-gnu/pkgconfig`:${env:PKG_CONFIG_PATH}"
}
cargo install --bin pyxis --root $env:PREFIX --path ./crates/pyxis-cli
