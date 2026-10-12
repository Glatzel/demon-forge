$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
cargo install --path . --features vendored-openssl @(Get-Cargo-Arg)
Copy-Item $env:RECIPE_DIR/win/etc $env:PREFIX/
Rename-Item $env:PREFIX/bin/rustup-init.exe $env:PREFIX/bin/rustup.exe
foreach($i in
   @(
    "cargo"
    "cargo-clippy"
    "cargo-fmt"
    "cargo-miri"
    "clippy-driver"
    "rls"
    "rust-analyzer"
    "rustc"
    "rustdoc"
    "rustfmt"
    "rust-gdb"
    "rust-gdbgui"
    "rust-lldb"
    )
){
    Copy-Item $env:PREFIX/bin/rustup.exe $env:PREFIX/bin/$i.exe
}
