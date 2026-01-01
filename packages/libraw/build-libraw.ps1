Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

$version = get-current-version
Set-Location $ROOT/temp/$name
git clone https://github.com/LibRaw/LibRaw.git
git clone --depth 1 https://github.com/LibRaw/LibRaw-cmake.git
Set-Location LibRaw
git checkout tags/$version -b "branch-$version"
Copy-Item ../LibRaw-cmake/* ./ -Recurse
cmake --build . --config Release --target install  -DCMAKE_INSTALL_PREFIX="$env:PREFIX"
