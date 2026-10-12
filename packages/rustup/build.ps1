$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
cargo install --path . --features vendored-openssl @(Get-Cargo-Arg)
Copy-Item $env:RECIPE_DIR/win/etc/ $env:PREFIX/ -recurse
Rename-Item $env:RECIPE_DIR/bin/rustup-init.exe $env:RECIPE_DIR/bin/rustup.exe
foreach($i in @(
        "rustc"
        "rustdoc"
        "rustfmt"
        "rust-gdb"
        "rust-gdbgui"
        "cargo"
        "cargo-clippy"
        "cargo-fmt"
        "cargo-miri"
        "clippy-driver"
        "rls"
        "rust-analyzer"
    ))
{
    copy-item $env:RECIPE_DIR/bin/rustup.exe $env:RECIPE_DIR/bin/$i.exe
}
