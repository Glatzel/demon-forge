$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
cargo install --path . --features vendored-openssl @(Get-Cargo-Arg)
Copy-Item $env:RECIPE_DIR/win/etc/ $env:PREFIX/ -recurse
Rename-Item $env:RECIPE_DIR/bin/rustup-init.exe $env:RECIPE_DIR/bin/rustup.exe
foreach($i in @(
        "cargo"
        "cargo-clippy"
        "cargo-fmt"
        "cargo-miri"
        "clippy-driver"
        "rls"
        "rust-analyzer"
        "rust-gdb"
        "rust-gdbgui"
        "rust-lldb"
        "rustc"
        "rustdoc"
        "rustfmt"
    ))
{
    copy-item $env:RECIPE_DIR/bin/rustup.exe $env:RECIPE_DIR/bin/$i.exe
}
