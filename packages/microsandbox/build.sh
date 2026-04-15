ROOT=$(git rev-parse --show-toplevel)
. "$ROOT/scripts/util.sh"
export LIBRARY_PATH="$(realpath $PREFIX/lib)"
set -- $(get_cargo_arg)
cargo install --path ./crates/cli "$@"
