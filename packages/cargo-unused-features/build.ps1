$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
cargo-build $env:PKG_NAME
Rename-Item $env:PREFIX/bin/unused-features.exe $env:PREFIX/bin/${env:PKG_NAME}.exe
