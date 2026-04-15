ROOT=$(git rev-parse --show-toplevel)
. "$ROOT/scripts/util.sh"
set -- $(get_cargo_arg)
cd rust
cargo install --bin pyxis --path ./crates/pyxis-cli "$@"
