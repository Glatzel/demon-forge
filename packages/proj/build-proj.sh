ROOT=$(git rev-parse --show-toplevel)
. "$ROOT/scripts/util.sh"
cmake-build \
    -DBUILD_APPS=ON \
    -DBUILD_SHARED_LIBS=ON \
    -DBUILD_TESTING=OFF \
    -DENABLE_IPO=ON \
    -DENABLE_CURL=ON \
    -DENABLE_TIFF=ON \
    -DEMBED_PROJ_DATA_PATH=OFF \
    -DEMBED_RESOURCE_FILES=ON
