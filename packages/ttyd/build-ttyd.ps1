$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
copy-item $PSScriptRoot/build/* ./ -recurse
get-content ./index.scss >> ./html/src/style/index.scss

if ($IsWindows) {
    Set-Location ./external/libwebsockets
    & "C:\msys64\msys2_shell.cmd" -here -no-start -defterm -c "pacman -S --noconfirm mingw-w64-x86_64-json-c"
    & "C:\msys64\msys2_shell.cmd" -here -no-start -defterm -c "pacman -S --noconfirm mingw-w64-x86_64-binutils && makepkg -s && pacman -U *.pkg.tar.zst"
    copy-item C:/msys64/mingw64/* $env:BUILD_PREFIX/Library -Recurse -force
    Set-Location $env:SRC_DIR

    $env:NPM_CONFIG_PREFIX = "$env:BUILD_PREFIX"
    $env:CMAKE_INSTALL_PREFIX = "$env:PREFIX/Library"
}
else {
    $env:CMAKE_INSTALL_PREFIX = "$env:PREFIX"
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
