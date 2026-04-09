cd $RECIPE_DIR
ROOT=$(git rev-parse --show-toplevel)
. "$ROOT/scripts/util.sh"
cd $SRC_DIR
dnf install -y libcap-ng-devel
set -- $(get_cargo_arg)
cargo install --path ./tools/shook "$@"
