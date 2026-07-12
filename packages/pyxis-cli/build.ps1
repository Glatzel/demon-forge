$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
cargo install --bin pyxis --path ./tools/pyxis-cli @(Get-Cargo-Arg)
