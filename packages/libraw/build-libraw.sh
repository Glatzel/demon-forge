export CMAKE_INSTALL_PREFIX="$PREFIX"
cp -r LibRaw-cmake/* .
cmake -S . -B build -G Ninja -DCMAKE_BUILD_TYPE=Release
cmake --build build --target install
