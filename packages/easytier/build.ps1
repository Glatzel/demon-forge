$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
cargo install @(Get-Cargo-Arg) --path ./easytier
Copy-Item ./easytier/third_party/Packet.dll $env:PREFIX/bin
Copy-Item ./easytier/third_party/wintun.dll $env:PREFIX/bin

