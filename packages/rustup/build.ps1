$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
cargo install --path . --features vendored-openssl @(Get-Cargo-Arg)
Copy-Item $env:RECIPE_DIR/win/etc/ $env:PREFIX/ -recurse
Rename-Item $env:PREFIX/bin/rustup-init.exe $env:PREFIX/bin/rustup.exe
foreach($i in @(
        "cargo"
        "cargo-clippy"
        "cargo-miri"
        "clippy-driver"
        "rls"
        "rust-gdb"
        "rust-gdbgui"
        "rust-lldb"
        "rustc"
        "rustdoc"
    ))
{
    copy-item $env:PREFIX/bin/rustup.exe $env:PREFIX/bin/$i.exe
}
