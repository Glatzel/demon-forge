$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
Set-Location ./tools/vinaya
cargo install --path ./tools/orc @(Get-Cargo-Arg)
