cd $RECIPE_DIR
ROOT=$(git rev-parse --show-toplevel)
. "$ROOT/scripts/util.sh"
cd $SRC_DIR
cmake_build
