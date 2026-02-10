$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
if ($IsWindows) {
    $env:CMAKE_INSTALL_PREFIX = "$ENV:PREFIX/Library"
}
else {
    $env:CMAKE_INSTALL_PREFIX = "$ENV:PREFIX"
}

cmake -S . -B build `
    -DCMAKE_BUILD_TYPE=Release `
    -DOCIO_INSTALL_EXT_PACKAGES=MISSING `
    -DCMAKE_BUILD_TYPE=Release `
    -DBUILD_SHARED_LIBS=ON `
    -DOCIO_BUILD_APPS=OFF `
    -DOCIO_USE_OIIO_FOR_APPS=OFF `
    -DOCIO_BUILD_PYTHON=OFF `
    -DOCIO_BUILD_OPENFX=OFF `
    -DOCIO_USE_SIMD=ON `
    -DOCIO_BUILD_TESTS=OFF `
    -DOCIO_BUILD_GPU_TESTS=OFF `
    -DOCIO_USE_HEADLESS=OFF `
    -DOCIO_WARNING_AS_ERROR=OFF `
    -DOCIO_BUILD_DOCS=OFF
cmake --build build --config Release --target install
