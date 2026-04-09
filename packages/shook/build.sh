cd $RECIPE_DIR
ROOT=$(git rev-parse --show-toplevel)
. "$ROOT/scripts/util.sh"
cd $SRC_DIR
set -- $(get_cargo_arg)
cargo install --path ./tools/shook "$@"
