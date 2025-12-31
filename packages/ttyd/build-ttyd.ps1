Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
$version = get-current-version
if ($IsWindows) {
    $env:PATH = "$env:BUILD_PREFIX/bin;$env:BUILD_PREFIX/Library/bin;$env:PATH"
}
if ($IsLinux) {
    $env:PATH = "$env:BUILD_PREFIX/bin`:$env:PATH"
}
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
$env:CMAKE_BUILD_TYPE = "RELEASE"
mkdir build
Set-Location build
if ($IsMacOS) {
    $env:WEB_SOCKET_LIBRARY = "$env:BUILD_PREFIX/lib"
    $env:WEB_SOCKET_INCLUDE_DIR = "$env:BUILD_PREFIX/include"
}
cmake `
    -DCMAKE_INSTALL_PREFIX="$env:PREFIX" `
    -DCMAKE_BUILD_TYPE="RELEASE" `
    ..
make
make install
