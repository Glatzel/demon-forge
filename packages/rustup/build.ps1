$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
cargo install --path . --features vendored-openssl @(Get-Cargo-Arg)
Copy-Item $env:RECIPE_DIR/win/etc/ $env:PREFIX/ -recurse
Rename-Item $env:PREFIX/bin/rustup-init.exe $env:PREFIX/bin/rustup.exe
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
    New-Item -ItemType SymbolicLink `
         -Path "$env:PREFIX/bin/$i.exe" `
         -Target "rustup.exe"
}
