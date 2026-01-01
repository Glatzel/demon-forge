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

&$env:BUILD_PREFIX/bin/npm install -g corepack
&$env:BUILD_PREFIX/bin/corepack enable
&$env:BUILD_PREFIX/bin/corepack prepare yarn@stable --activate
&$env:BUILD_PREFIX/bin/yarn install
&$env:BUILD_PREFIX/bin/yarn run check
&$env:BUILD_PREFIX/bin/yarn run build
Set-Location ..
mkdir build
Set-Location build

if ($IsMacOS) {
    &$env:BUILD_PREFIX/bin/cmake `
        -DCMAKE_INSTALL_PREFIX="$env:PREFIX" `
        -DCMAKE_BUILD_TYPE="RELEASE" `
        -DOPENSSL_ROOT_DIR="$env:BUILD_PREFIX" `
        -Dlibwebsockets_DIR="$env:BUILD_PREFIX/lib/cmake/libwebsockets" `
        ..
}
if ($IsLinux) {
    &$env:BUILD_PREFIX/bin/cmake `
        -DCMAKE_INSTALL_PREFIX="$env:PREFIX" `
        -DCMAKE_BUILD_TYPE="RELEASE" `
        ..
}

&$env:BUILD_PREFIX/bin/make VERBOSE=1
&$env:BUILD_PREFIX/bin/make install
