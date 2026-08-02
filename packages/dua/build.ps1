$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
cargo +nightly install dua-cli @(Get-Cargo-Arg)
