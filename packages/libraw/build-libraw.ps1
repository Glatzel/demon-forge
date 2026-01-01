Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

$version = get-current-version
Set-Location $ROOT/temp/$name
git clone https://github.com/LibRaw/LibRaw.git
Set-Location $name
git checkout tags/$version -b "branch-$version"
git clone https://github.com/LibRaw/LibRaw-cmake.git

mkdir build
Set-Location build
cmake `
        -DCMAKE_INSTALL_PREFIX="$env:PREFIX" `
        -DCMAKE_BUILD_TYPE="RELEASE" `
        ..
cmake --build .
cmake --install .
