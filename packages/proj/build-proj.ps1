Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
Set-Location $env:SRC_DIR

mkdir build
Set-Location build
cmake -DCMAKE_BUILD_TYPE="RELEASE" ..
cmake --build . --config Release --target install
