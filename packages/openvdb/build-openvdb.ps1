$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
$cmakeArgs = @(
    "-DOPENVDB_BUILD_VDB_PRINT=OFF"
    "-DOPENVDB_INSTALL_CMAKE_MODULES=ON"
    "-DOPENVDB_CORE_SHARED=ON"
    "-DOPENVDB_CORE_STATIC=OFF"
)
cmake-build @cmakeArgs
