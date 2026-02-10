Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
Set-Location $env:SRC_DIR

if ($IsWindows) {
    $env:CMAKE_GENERATOR_PLATFORM = "x64"
    $env:CMAKE_GENERATOR_TOOLSET = "v143"
    $env:CMAKE_INSTALL_PREFIX = "$env:PREFIX/Library"
}
if ($IsMacOS) {
    $env:CMAKE_INSTALL_PREFIX = "$env:PREFIX"
}
if ($IsLinux) {
    $env:CMAKE_INSTALL_PREFIX = "$env:PREFIX"
}

cmake -S . -B build -`
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
