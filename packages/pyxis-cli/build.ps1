$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
Set-Location rust
cargo install --path ./tools/pyxis-cli @(Get-Cargo-Arg)
