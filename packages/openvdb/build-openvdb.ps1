$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
$cmakeArgs = @(
    "-G"
    "Ninja"
    "-DCMAKE_BUILD_TYPE=Release"

)
if ($IsWindows) {
    $cmakeArgs += @(
        "-CMAKE_INSTALL_PREFIX=$ENV:PREFIX/Library"
    )
}
else {
    $cmakeArgs += @(
        "-CMAKE_INSTALL_PREFIX=$ENV:PREFIX"
        "-DOPENVDB_BUILD_AX=ON"
    )
}
cmake -S . -B build @cmakeArgs
cmake --build build --config Release --target install
