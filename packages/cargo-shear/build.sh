ROOT=$(git rev-parse --show-toplevel)
. "$ROOT/scripts/util.sh"
set -- $(get-cargo-arg)
cargo install "$PKG_NAME" "$@"
