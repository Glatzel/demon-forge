ROOT=$(git rev-parse --show-toplevel)
. "$ROOT/scripts/util.sh"
set -- $(get_cargo_arg)
cargo install --bin pyxis --path ./tools/pyxis-cli "$@"
