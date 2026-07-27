$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
cargo install dua-cli @(Get-Cargo-Arg)
