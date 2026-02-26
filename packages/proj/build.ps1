$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
if ($IsWindows) {
    $env:CMAKE_INSTALL_PREFIX = "$env:PREFIX/Library"
}
else {
    $env:CMAKE_INSTALL_PREFIX = "$env:PREFIX"
}
cmake -S . -B build -G Ninja `
    -DCMAKE_BUILD_TYPE="RELEASE" `
    -DBUILD_APPS=ON `
    -DBUILD_SHARED_LIBS=ON `
    -DBUILD_TESTING=OFF `
    -DENABLE_IPO=ON `
    -DENABLE_CURL=ON `
    -DENABLE_TIFF=ON `
    -DEMBED_PROJ_DATA_PATH=OFF `
    -DEMBED_RESOURCE_FILES=ON
cmake --build build --config Release --target install
