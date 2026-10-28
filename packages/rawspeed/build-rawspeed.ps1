Set-Location $env:RECIPE_DIR
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
Set-Location $env:SRC_DIR
git submodule update --init --recursive --depth 1 -- src/external/rawspeed
Set-Location src/external
Copy-Item $env:RECIPE_DIR/CMakeLists.txt ./CMakeLists.txt

$env:CC  = "clang-cl"
$env:CXX = "clang-cl"

# Host env (where zlib/jpeg/pugixml live), NOT the build env
$prefix      = (Resolve-Path $env:PREFIX).Path.Replace('\', '/')
$buildPrefix = (Resolve-Path $env:BUILD_PREFIX).Path.Replace('\', '/')

cmake-build `
    -DCMAKE_BUILD_TYPE=Release `
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
    -DRAWSPEED_ENABLE_WERROR=OFF `
    "-DCMAKE_PREFIX_PATH=$prefix/Library;$prefix" `
    "-DCMAKE_IGNORE_PREFIX_PATH=$buildPrefix/Library;$buildPrefix" `
    "-DZLIB_ROOT=$prefix/Library" `
    "-DZLIB_INCLUDE_DIR=$prefix/Library/include" `
    "-DZLIB_LIBRARY=$prefix/Library/lib/z.lib"
