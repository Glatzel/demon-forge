Set-Location $env:RECIPE_DIR
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
Set-Location $env:SRC_DIR
git submodule update --init --recursive --depth 1 -- src/external/rawspeed
Set-Location src/external
Copy-Item $env:RECIPE_DIR/CMakeLists.txt ./CMakeLists.txt
$env:CC="clang-cl"
$env:CXX="clang-cl"
cmake-build `
    -DBINARY_PACKAGE_BUILD=ON `
    -DWITH_OPENMP=ON `
    -DWITH_PUGIXML=ON `
    -DWITH_JPEG=ON `
    -DWITH_ZLIB=ON `
    -DBUILD_TESTING=OFF `
    -DBUILD_TOOLS=OFF `
    -DBUILD_BENCHMARKING=OFF `
    -DBUILD_DOCS=OFF `
    -DBUILD_FUZZERS=OFF `
    -DUSE_XMLLINT=OFF `
    -DUSE_CLANG_TIDY=OFF `
    -DRAWSPEED_ENABLE_DEBUG_INFO=OFF `
    -DRAWSPEED_ENABLE_WERROR=ON
