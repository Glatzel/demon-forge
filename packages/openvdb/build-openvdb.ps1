$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
$cmakeArgs = @(
    "-G"
    "Ninja"
    "-DCMAKE_BUILD_TYPE=Release"
    "-DOPENVDB_BUILD_VDB_PRINT=OFF"
    "-OPENVDB_INSTALL_CMAKE_MODULES=ON"
    "-DOPENVDB_CORE_SHARED=ON"
    "-DOPENVDB_CORE_STATIC=OFF"

)
if ($IsWindows) {
    $cmakeArgs += @(
        "-DCMAKE_INSTALL_PREFIX=$ENV:PREFIX/Library"
    )
}
else {
    $cmakeArgs += @(
        "-DCMAKE_INSTALL_PREFIX=$ENV:PREFIX"
        "-DOPENVDB_BUILD_AX=ON"
    )
}
cmake -S . -B build @cmakeArgs
cmake --build build --config Release --target install
