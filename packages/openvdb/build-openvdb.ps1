$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
if ($IsWindows) {
    $env:CMAKE_INSTALL_PREFIX = "$ENV:PREFIX/Library"
}
else {
    $env:CMAKE_INSTALL_PREFIX = "$ENV:PREFIX"
}
$cmakeArgs = @(
    "-G"
    "Ninja"
    "-DCMAKE_BUILD_TYPE=Release"

)
if (-not $IsWindows) {
    $cmakeArgs += @("-DOPENVDB_BUILD_AX=ON")
}
cmake -S . -B build @cmakeArgs
cmake --build build --config Release --target install
