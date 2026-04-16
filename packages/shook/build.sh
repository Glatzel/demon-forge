export LIBRARY_PATH="$PREFIX/lib"
ROOT=$(git rev-parse --show-toplevel)
. "$ROOT/scripts/util.sh"
set -- $(get_cargo_arg)
cargo install --path ./tools/shook "$@"
