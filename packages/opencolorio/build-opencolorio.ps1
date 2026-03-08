$cmakeArgs = @(
    "-S", "."
    "-B", "build"
    "-G", "Ninja"
    "-DCMAKE_BUILD_TYPE=Release"
    "-DOCIO_INSTALL_EXT_PACKAGES=MISSING"
    "-DCMAKE_BUILD_TYPE=Release"
    "-DBUILD_SHARED_LIBS=ON"
    "-DOCIO_BUILD_PYTHON=OFF"
    "-DOCIO_BUILD_OPENFX=OFF"
    "-DOCIO_USE_SIMD=ON"
    "-DOCIO_BUILD_TESTS=OFF"
    "-DOCIO_BUILD_GPU_TESTS=OFF"
    "-DOCIO_USE_HEADLESS=OFF"
    "-DOCIO_WARNING_AS_ERROR=OFF"
    "-DOCIO_BUILD_DOCS=OFF"
    "-DOCIO_BUILD_APPS=OFF"
    "-DOCIO_USE_OIIO_FOR_APPS=OFF"
)
if ($IsWindows) {
    $cmakeArgs += @("-DCMAKE_INSTALL_PREFIX=${ENV:PREFIX}/Library")
}
else {
    $cmakeArgs += @("-DCMAKE_INSTALL_PREFIX=${ENV:PREFIX}")
}
cmake  @cmakeArgs
cmake --build build --config Release --target install
