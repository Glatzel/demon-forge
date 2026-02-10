$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
if ($IsWindows) {
    $env:CMAKE_INSTALL_PREFIX = "$env:PREFIX/Library"
}
if ($IsMacOS) {
    $env:CMAKE_INSTALL_PREFIX = "$env:PREFIX"
}
if ($IsLinux) {
    $env:CMAKE_INSTALL_PREFIX = "$env:PREFIX"
}
Copy-Item ./LibRaw-cmake/* ./ -Recurse
cmake -S . -B build -DCMAKE_BUILD_TYPE="RELEASE"
cmake --build build --config Release --target install
