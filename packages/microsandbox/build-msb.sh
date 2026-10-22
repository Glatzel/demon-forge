ROOT=$(git rev-parse --show-toplevel)
. "$ROOT/scripts/util.sh"
export LIBRARY_PATH="$(realpath $PREFIX/lib):$LIBRARY_PATH"
set -- $(get_cargo_arg)
cargo install --path ./crates/cli "$@"
