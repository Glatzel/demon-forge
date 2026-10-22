ROOT=$(git rev-parse --show-toplevel)
. "$ROOT/scripts/util.sh"
cmake_build \
    -DOPENVDB_BUILD_VDB_PRINT=OFF \
    -DOPENVDB_INSTALL_CMAKE_MODULES=ON \
    -DOPENVDB_CORE_SHARED=ON \
    -DOPENVDB_CORE_STATIC=OFF
