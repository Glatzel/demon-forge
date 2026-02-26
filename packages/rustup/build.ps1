$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
cargo install --path . @(Get-Cargo-Arg)
if($IsWindows){copy-item $env:PREFIX/bin/rustup-init.exe $env:PREFIX/bin/rustup.exe}
else{copy-item $env:PREFIX/bin/rustup-init $env:PREFIX/bin/rustup}
