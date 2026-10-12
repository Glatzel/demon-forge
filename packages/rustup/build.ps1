$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
cargo install --path . --features vendored-openssl @(Get-Cargo-Arg)
Copy-Item $env:RECIPE_DIR/win/etc/ $env:PREFIX/ -recurse
New-item $env:PREFIX/.cargo/bin -itemtype directory
Move-Item $env:PREFIX/bin/rustup-init.exe $env:PREFIX/.cargo/bin/rustup.exe
