cmake -S . -B build \
    -G "Ninja" \
    -DCMAKE_BUILD_TYPE=Release \
    -DOPENVDB_BUILD_VDB_PRINT=OFF \
    -DOPENVDB_INSTALL_CMAKE_MODULES=ON \
    -DOPENVDB_CORE_SHARED=ON \
    -DOPENVDB_CORE_STATIC=OFF \
    -DCMAKE_INSTALL_PREFIX="$PREFIX"
cmake --build build --config Release --target install
