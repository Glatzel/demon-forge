$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
cargo install fd-find @(Get-Cargo-Arg)
