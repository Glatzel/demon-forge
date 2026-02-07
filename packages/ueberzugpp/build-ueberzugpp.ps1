$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
$cmakeArgs = @(
    "-G"
    "Ninja"
    "-DVERBOSE=ON"
    "-DCMAKE_BUILD_TYPE=Release"
    "-DCMAKE_INSTALL_PREFIX=$env:PREFIX"
    "-DENABLE_X11=OFF"
    "-DENABLE_OPENCV=OFF"
)
if ($IsMacOS) { $cmakeArgs += "-DCMAKE_CXX_COMPILER_CLANG_SCAN_DEPS=$env:BUILD_PREFIX/bin/clang-scan-deps" }
cmake -S . -B build $cmakeArgs
cmake --build build --config Release --target install
