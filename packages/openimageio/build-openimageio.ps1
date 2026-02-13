$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

# Common CMake options
$cmakeArgs = @(
    "-G"
    "Ninja"
    "-DVERBOSE=ON"
    "-DCMAKE_BUILD_TYPE=Release"
    "-DBUILD_DOCS=0"
    "-DBUILD_SHARED_LIBS=1"
    "-DENABLE_INSTALL_testtex=0"
    "-DENABLE_libuhdr=0"
    "-DENABLE_Nuke=0"
    "-DENABLE_OpenVDB=0"
    "-DENABLE_Ptex=0"
    "-DENABLE_Python3=0"
    "-DINSTALL_DOCS=0"
    "-DLINKSTATIC=0"
    "-DOIIO_BUILD_TESTS=0"
    "-DUSE_PYTHON=0"
    "-DUSE_QT=0"
)

if ($IsWindows) {
    $cmakeArgs += @(
        "-DCMAKE_C_FLAGS=/utf-8"
        "-DCMAKE_CXX_FLAGS=/utf-8"
        "-DUSE_SIMD=sse4.2,avx2"
        "-DCMAKE_INSTALL_PREFIX=$ENV:PREFIX/Library"
        
    )
}
if ($IsMacOS) {
    $cmakeArgs += @(
    "-DCMAKE_INSTALL_PREFIX=$ENV:PREFIX"
    "-DENABLE_DCMTK=0"
    )
}
if ($IsLinux) {
    $cmakeArgs += @("-DCMAKE_INSTALL_PREFIX=$ENV:PREFIX")
    if ($env:TARGET_PLATFORM -eq 'linux-64') {
        $cmakeArgs += @( "-DUSE_SIMD=sse4.2,avx2")
    }
}

cmake -S . -B build @cmakeArgs
cmake --build build --config Release --target install
