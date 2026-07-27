$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
cargo install du-dust @(Get-Cargo-Arg)
