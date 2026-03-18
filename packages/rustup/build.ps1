$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
cargo install --path . @(Get-Cargo-Arg)
if ($IsWindows) {
    Rename-Item $env:PREFIX/bin/rustup-init.exe $env:PREFIX/bin/rustup.exe
    Copy-Item $env:RECIPE_DIR/win/* $env:PREFIX -Recurse
}
else {
    Rename-Item $env:PREFIX/bin/rustup-init $env:PREFIX/bin/rustup
    Copy-Item $env:RECIPE_DIR/unix/* $env:PREFIX -Recurse
}
