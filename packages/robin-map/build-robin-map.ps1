$cmakeArgs = @(
    "-G", "Ninja"
    "-DCMAKE_BUILD_TYPE=Release"
    "-DCMAKE_INSTALL_PREFIX=$ENV:PREFIX/Library"
)
cmake -S . -B build @cmakeArgs
cmake --build build --config Release --target install
