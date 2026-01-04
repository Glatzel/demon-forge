Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

install-rust
if ($IsLinux) {
    dnf install -y systemd-devel
}
Set-Location $env:SRC_DIR/rust
& ./scripts/setup.ps1
cargo build --bin pyxis --release
New-Item $env:PREFIX/bin -ItemType Directory
if ($IsWindows) {
    Copy-Item ./target/release/pyxis.exe "$env:PREFIX/bin/"
}
else {
    Copy-Item ./target/release/pyxis "$env:PREFIX/bin/"
}
