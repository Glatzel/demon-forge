$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
cargo install --path . --features vendored-openssl @(Get-Cargo-Arg)
Copy-Item $env:RECIPE_DIR/win/etc/ $env:PREFIX/ -recurse
New-item $env:PREFIX/.cargo/bin -itemtype directory
Move-Item $env:PREFIX/bin/rustup-init.exe $env:PREFIX/.cargo/bin/rustup.exe
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
         "rustup"
     ))
 {
     Copy-Item "$env:PREFIX/.cargo/bin/rustup.exe" "$env:PREFIX/bin/$i.exe"
 }
