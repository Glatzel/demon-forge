cmake -S . -B build -G Ninja `
    -DCMAKE_BUILD_TYPE=Release `
    -DCMAKE_INSTALL_PREFIX="$env:PREFIX/Library"
cmake --build build --config Release --target install
