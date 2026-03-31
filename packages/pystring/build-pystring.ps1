cmake -S . -B build "-G" `
    "Ninja" `
    "-DVERBOSE=ON" `
    "-DCMAKE_BUILD_TYPE=Release" `
    "-DCMAKE_INSTALL_PREFIX=$ENV:PREFIX/Library"
cmake --build build --config Release --target install
