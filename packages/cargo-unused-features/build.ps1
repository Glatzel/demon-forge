$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
cargo install $env:PKG_NAME @(Get-Cargo-Arg)
Rename-Item $env:PREFIX/bin/unused-features.exe $env:PREFIX/bin/${env:PKG_NAME}.exe
