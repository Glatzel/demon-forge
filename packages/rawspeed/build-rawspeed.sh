cd $RECIPE_DIR
ROOT=$(git rev-parse --show-toplevel)
. "$ROOT/scripts/util.sh"
cd $SRC_DIR
git submodule update --init --recursive --depth 1 -- src/external/rawspeed
cd src/external
cp $RECIPE_DIR/CMakeLists.txt ./CMakeLists.txt

# conda's toolchain flags (sysroot, deployment target, prefix path, cross-compile)
read -r -a conda_cmake_args <<< "${CMAKE_ARGS:-}"

platform_args=()
if [[ "$(uname)" == "Darwin" ]]; then
    platform_args+=(
        -DCMAKE_PREFIX_PATH="${PREFIX}"
        -DOpenMP_ROOT="${PREFIX}"
        -DCMAKE_OSX_DEPLOYMENT_TARGET=13.5
    )
fi

cmake_build \
    "${conda_cmake_args[@]}" \
    "${platform_args[@]}" \
    -DBINARY_PACKAGE_BUILD=ON \
    -DWITH_OPENMP=ON \
    -DWITH_PUGIXML=ON \
    -DWITH_JPEG=ON \
    -DWITH_ZLIB=ON \
    -DBUILD_TESTING=OFF \
    -DBUILD_TOOLS=OFF \
    -DBUILD_BENCHMARKING=OFF \
    -DBUILD_DOCS=OFF \
    -DBUILD_FUZZERS=OFF \
    -DUSE_XMLLINT=OFF \
    -DUSE_CLANG_TIDY=OFF \
    -DRAWSPEED_ENABLE_DEBUG_INFO=OFF \
    -DRAWSPEED_ENABLE_WERROR=OFF
