Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
Set-Location $env:SRC_DIR

if ($IsWindows) {
    $env:CMAKE_GENERATOR = "Visual Studio 17 2022"
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
if ($env:DIST_BUILD) {$env:DCMAKE_BUILD_TYPE="RELEASE"}
mkdir build
Set-Location build
cmake `
    -DBUILD_APPS=ON `
    -DBUILD_SHARED_LIBS=ON `
    -DBUILD_TESTING=OFF `
    -DENABLE_IPO=ON `
    -DENABLE_CURL=ON `
    -DENABLE_TIFF=ON `
    -DEMBED_PROJ_DATA_PATH=OFF `
    -DEMBED_RESOURCE_FILES=ON `
    ..
if ($env:DIST_BUILD) {
    cmake --build . --config Release --target install
}
else{
    cmake --build . --target install
}

