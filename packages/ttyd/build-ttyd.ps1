$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
copy-item $PSScriptRoot/build/* ./ -recurse
get-content ./index.scss >> ./html/src/style/index.scss
& ./download-font.ps1

Set-Location ./html
if ($IsWindows) {
    $env:NPM_CONFIG_PREFIX = "$env:BUILD_PREFIX"
    $env:CMAKE_INSTALL_PREFIX="$env:PREFIX/Library"
    pacman -S mingw-w64-json-c
    pacman -S mingw-w64-libwebsockets
}
else{
$env:CMAKE_INSTALL_PREFIX="$env:PREFIX"
}
npm install -g corepack
corepack enable
corepack prepare yarn@stable --activate
yarn install
yarn run check
yarn run build
Set-Location ..
mkdir build
Set-Location build

cmake -S . -B build -DCMAKE_BUILD_TYPE="RELEASE"
cmake --build build --config Release --target install
