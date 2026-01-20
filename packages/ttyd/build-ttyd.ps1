$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
copy-item $PSScriptRoot/build/* ./ -recurse
get-content ./index.scss >> ./html/src/style/index.scss

# Download and install fonts
& ./download-font.ps1
$env:NPM_CONFIG_PREFIX = "$env:BUILD_PREFIX"
Set-Location ./html
npm install -g corepack
corepack enable
corepack prepare yarn@stable --activate
yarn install
yarn run check
yarn run build
Set-Location ..
if ($IsWindows) {
    & "C:\msys64\msys2_shell.cmd" -here -no-start -defterm -ucrt64 -c "pacman -S --noconfirm base-devel subversion mingw-w64-ucrt-x86_64-gcc mingw-w64-ucrt-x86_64-cmake mingw-w64-ucrt-x86_64-zlib mingw-w64-ucrt-x86_64-libuv mingw-w64-ucrt-x86_64-mbedtls mingw-w64-ucrt-x86_64-json-c"
    & "C:\msys64\msys2_shell.cmd" -here -no-start -defterm -ucrt64 -c "./scripts/mingw-build.sh"
}
else {
    $cmakeArgs = @(
        "-G"
        "Ninja"
        "-DVERBOSE=ON"
        "-DCMAKE_BUILD_TYPE=Release"
        "-DCMAKE_INSTALL_PREFIX=$env:PREFIX"
    )
    cmake -S . -B build @cmakeArgs
    cmake --build build --config Release --target install
}
