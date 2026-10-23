$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
cargo-build --bin pyxis --path ./tools/pyxis-cli
