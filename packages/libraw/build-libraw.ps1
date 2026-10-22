$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
Copy-Item ./LibRaw-cmake/* ./ -Recurse
cmake-build
