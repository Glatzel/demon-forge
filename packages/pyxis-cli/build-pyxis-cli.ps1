Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

install-rust
if ($IsLinux) {
    dnf update -y
    dnf install -y systemd-devel gcc-toolset-10-gcc gcc-toolset-10-gcc-c++
    $env:PATH = "/opt/rh/gcc-toolset-10/root/usr/bin`:$env:PATH"
    $env:LD_LIBRARY_PATH = "/opt/rh/gcc-toolset-10/root/usr/lib64`:$env:LD_LIBRARY_PATH"
    $env:CXX = "g++"
    $env:CC = "gcc"
    gcc --version
    g++ --version
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
