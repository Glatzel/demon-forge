$cmakeArgs = @(
    "-G"
    "Ninja"
    "-DCMAKE_BUILD_TYPE=Release"
    "-DOPENVDB_BUILD_VDB_PRINT=OFF"
    "-DOPENVDB_INSTALL_CMAKE_MODULES=ON"
    "-DOPENVDB_CORE_SHARED=ON"
    "-DOPENVDB_CORE_STATIC=OFF"
    "-DCMAKE_INSTALL_PREFIX=$ENV:PREFIX/Library"
)
cmake -S . -B build @cmakeArgs
cmake --build build --config Release --target install
