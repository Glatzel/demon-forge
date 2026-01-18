$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
copy-item $PSScriptRoot/build/* ./ -recurse
get-content ./index.scss >> ./html/src/style/index.scss

if ($IsWindows) {
    $env:NPM_CONFIG_PREFIX = "$env:BUILD_PREFIX"
    $env:CMAKE_INSTALL_PREFIX="$env:BUILD_PREFIX/Library"
    $env:BUILD_SHARED_LIBS="OFF"
Get-ChildItem -Path "C:\msys64" -Recurse -Filter "pacman.exe"
    & C:/msys64/usr/bin/pacman.exe -S mingw-w64-json-c mingw-w64-libwebsockets
    $env:CMAKE_INSTALL_PREFIX="$env:PREFIX/Library"
}
else{
    $env:CMAKE_INSTALL_PREFIX="$env:PREFIX"
}

& ./download-font.ps1
Set-Location ./html
npm install -g corepack
corepack enable
corepack prepare yarn@stable --activate
yarn install
yarn run check
yarn run build
Set-Location ..
cmake -S . -B build -DCMAKE_BUILD_TYPE="RELEASE"
cmake --build build --config Release --target install
