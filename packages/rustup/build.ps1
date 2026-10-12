rustup self uninstall -y
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
cargo install --path . --features vendored-openssl @(Get-Cargo-Arg)
Copy-Item $env:RECIPE_DIR/win/etc $env:PREFIX/
$env:RUSTUP_HOME= "$PREFIX/.rustup"
$env:CARGO_HOME= "$PREFIX/"
& $env:PREFIX/bin/rustup-init -y --default-toolchain stable --profile complete
Remove-Item $PREFIX/.rustup -Recurse -force
Remove-Item $PREFIX/bin/rustup-init*
