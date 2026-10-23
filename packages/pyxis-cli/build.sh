ROOT=$(git rev-parse --show-toplevel)
. "$ROOT/scripts/util.sh"
cargo_build --bin pyxis --path ./tools/pyxis-cli
