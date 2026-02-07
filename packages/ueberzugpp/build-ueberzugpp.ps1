$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
if ($IsMacOS) { $env:CMAKE_CXX_COMPILER_CLANG_SCAN_DEPS = "$env:BUILD_PREFIX/bin/clang-scan-deps" }
cmake -S . -B build `
    -G "Ninja" `
    -DVERBOSE=ON `
    -DCMAKE_BUILD_TYPE=Release `
    -DCMAKE_INSTALL_PREFIX="$env:PREFIX" `
    -DENABLE_X11=OFF `
    -DENABLE_OPENCV=OFF
cmake --build build --config Release --target install
