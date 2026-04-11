$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
Set-Location rust
cargo install --bin pyxis --path ./crates/pyxis-cli @(Get-Cargo-Arg)
