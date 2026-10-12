rustup self uninstall -y
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
cargo install --path . --features vendored-openssl @(Get-Cargo-Arg)
Copy-Item $env:RECIPE_DIR/win/etc/ $env:PREFIX/ -recurse
$env:RUSTUP_HOME= "$env:PREFIX/.rustup"
$env:CARGO_HOME= "$env:PREFIX/"
& $env:PREFIX/bin/rustup-init -y --default-toolchain stable --profile complete
Remove-Item $env:PREFIX/.rustup -Recurse -force
Remove-Item $env:PREFIX/bin/rustup-init*
