cmake -S . -B build -G Ninja \
    -DFORCE_COLORED_OUTPUT=1 \
    -DCMAKE_INSTALL_PREFIX="${PREFIX}" \
    -DCMAKE_BUILD_TYPE=Release \
    -DOVERRIDE_GIT_DESCRIBE=""

cmake --build build --config Release --target install
