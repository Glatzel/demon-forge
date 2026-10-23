$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
Set-Location ./tools/vinaya/crates/vinaya-cli
cargo-build --path .
