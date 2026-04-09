cd $RECIPE_DIR
ROOT=$(git rev-parse --show-toplevel)
. "$ROOT/scripts/util.sh"
cd $SRC_DIR
sudo apt-get update && sudo apt-get install -y libcap-ng-dev
set -- $(get_cargo_arg)
cargo install --path ./tools/shook "$@"
