Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

$version = get-current-version
Set-Location $ROOT/temp/$name
git clone https://github.com/tsl0922/ttyd.git
Set-Location $name

git checkout tags/$version -b "branch-$version"
copy-item $PSScriptRoot/build/* $ROOT/temp/$name/$name -recurse
git apply config.patch
get-content ./index.scss >> ./html/src/style/index.scss
& ./download-font.ps1

Set-Location ./html

npm install -g corepack
corepack enable
corepack prepare yarn@stable --activate
yarn install
yarn run check
yarn run build
Set-Location ..
mkdir build
Set-Location build

if ($IsMacOS) {
    brew install -v libwebsockets
    # cmake `
    #     -DCMAKE_INSTALL_PREFIX="$env:PREFIX" `
    #     -DCMAKE_BUILD_TYPE="RELEASE" `
    #     -DCMAKE_PREFIX_PATH="$BUILD_PREFIX" `
    #     -DOPENSSL_ROOT_DIR="$env:BUILD_PREFIX" `
    #     -Dlibwebsockets_DIR="/opt/homebrew/Cellar/libwebsockets/lib/cmake" `
    #     -DZLIB_ROOT="$env:BUILD_PREFIX" `
    #     -DLIBUV_INCLUDE_DIR="$env:BUILD_PREFIX/include" `
    #     -DLIBUV_LIBRARY="$env:BUILD_PREFIX/lib/libuv.dylib" `
    #     ..
        cmake `
        -DCMAKE_INSTALL_PREFIX="$env:PREFIX" `
        -DCMAKE_BUILD_TYPE="RELEASE" `
        -Dlibwebsockets_DIR="/opt/homebrew/Cellar/libwebsockets/lib/cmake" `
        ..
}
if ($IsLinux) {
    cmake `
        -DCMAKE_INSTALL_PREFIX="$env:PREFIX" `
        -DCMAKE_BUILD_TYPE="RELEASE" `
        ..
}

make VERBOSE=1
make install
