$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
cmake-build `
    "-DCMAKE_WINDOWS_EXPORT_ALL_SYMBOLS=ON"
