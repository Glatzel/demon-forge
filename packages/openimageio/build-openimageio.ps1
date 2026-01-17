$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
if ($IsWindows) {
    $env:CMAKE_INSTALL_PREFIX = "$ENV:PREFIX/Library"
    $env:C_FLAGS = "$env:CFLAGS /utf-8"
    $env:CXX_FLAGS = "$env:CFLAGS /utf-8"
    $env:USE_SIMD = "sse4.2,avx2"
}
if ($IsLinux) {
    $env:CMAKE_INSTALL_PREFIX = "$ENV:PREFIX"
    if ($arch -eq "X64") {
        $env:USE_SIMD = "sse4.2,avx2"
    }
}

cmake -S . -B build `
    -DVERBOSE=ON `
    -DCMAKE_BUILD_TYPE=Release `
    -DBUILD_DOCS=0 `
    -DBUILD_SHARED_LIBS=1 `
    -DENABLE_DCMTK=0 `
    -DENABLE_FFmpeg=0 `
    -DENABLE_INSTALL_testtex=0 `
    -DENABLE_libuhdr=0 `
    -DENABLE_Nuke=0 `
    -DENABLE_OpenCV=0 `
    -DENABLE_OpenVDB=0 `
    -DENABLE_Ptex=0 `
    -DENABLE_Python3=0 `
    -DINSTALL_DOCS=0 `
    -DLINKSTATIC=0 `
    -DOIIO_BUILD_TESTS=0 `
    -DUSE_PYTHON=0 `
    -DUSE_QT=0
cmake --build build --config Release --target install
