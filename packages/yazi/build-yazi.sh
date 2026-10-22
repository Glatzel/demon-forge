ROOT=$(git rev-parse --show-toplevel)
. "$ROOT/scripts/util.sh"
set -- $(get_cargo_arg)
cargo install --path ./yazi-fm "$@"
cargo install --path ./yazi-cli "$@"
