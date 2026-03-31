$env:CMAKE_INSTALL_PREFIX = "$env:PREFIX/Library"
Copy-Item ./LibRaw-cmake/* ./ -Recurse
cmake -S . -G Ninja -B build -DCMAKE_BUILD_TYPE="RELEASE"
cmake --build build --config Release --target install
