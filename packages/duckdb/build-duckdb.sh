ROOT=$(git rev-parse --show-toplevel)
. "$ROOT/scripts/util.sh"
cmake_build \
    -DFORCE_COLORED_OUTPUT=1 \
    -DOVERRIDE_GIT_DESCRIBE="" \
    -DBUILD_UNITTESTS=OFF \
    -DENABLE_UNITTEST_CPP_TESTS=OFF
