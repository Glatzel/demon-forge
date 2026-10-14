git submodule update --init
cmake -S . -B build -G Ninja -DCMAKE_INSTALL_PREFIX="$PREFIX" -DCMAKE_BUILD_TYPE=RELEASE
cmake --build build --config Release --target install
