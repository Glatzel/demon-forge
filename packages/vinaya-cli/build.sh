ROOT=$(git rev-parse --show-toplevel)
. "$ROOT/scripts/util.sh"
set -- $(get_cargo_arg)
cd ./tools/vinaya/crates/vinaya-cli
cargo install --path . "$@"
