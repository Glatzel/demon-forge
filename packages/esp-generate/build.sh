ROOT=$(git rev-parse --show-toplevel)
. "$ROOT/scripts/util.sh"
cargo install "$PKG_NAME" "$(get_cargo_arg)"
