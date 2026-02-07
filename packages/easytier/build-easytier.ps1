$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
cargo install @(Get-Cargo-Arg) --path ./easytier
