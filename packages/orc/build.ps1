$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
Set-Location ./tools/vinaya
cargo install --path . @(Get-Cargo-Arg)
