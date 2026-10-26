ROOT=$(git rev-parse --show-toplevel)
. "$ROOT/scripts/util.sh"
cp -r LibRaw-cmake/* .
cmake_build
