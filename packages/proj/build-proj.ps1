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
mkdir build
Set-Location build
cmake -DCMAKE_BUILD_TYPE="RELEASE" ..
cmake --build . --config Release --target install
