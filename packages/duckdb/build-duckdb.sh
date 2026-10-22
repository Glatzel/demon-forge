ROOT=$(git rev-parse --show-toplevel)
. "$ROOT/scripts/util.sh"
cmake-build \
    -DFORCE_COLORED_OUTPUT=1 \
    -DOVERRIDE_GIT_DESCRIBE=""
