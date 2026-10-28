cd $RECIPE_DIR
ROOT=$(git rev-parse --show-toplevel)
. "$ROOT/scripts/util.sh"
cd $SRC_DIR
cd src/external/rawspeed
cmake_build
