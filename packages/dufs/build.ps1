$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

cargo install $name @(Get-Cargo-Arg)
Rename-Item $env:PREFIX/bin/unused-features.exe $env:PREFIX/bin/${env:PKG_NAME}.exe


    Rename-Item $env:PREFIX/bin/unused-features $env:PREFIX/bin/${env:PKG_NAME}
