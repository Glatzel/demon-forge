ROOT=$(git rev-parse --show-toplevel)
. "$ROOT/scripts/util.sh"
cmake_build
tree -L 4 $PREFIX
