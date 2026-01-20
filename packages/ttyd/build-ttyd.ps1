$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
copy-item $PSScriptRoot/build/* ./ -recurse
get-content ./index.scss >> ./html/src/style/index.scss

# Common CMake options
$cmakeArgs = @(
    "-G"
    "Ninja"
    "-DVERBOSE=ON"
    "-DCMAKE_BUILD_TYPE=Release"
    "-DCMAKE_INSTALL_PREFIX=$env:PREFIX"
)



# Download and install fonts
& ./download-font.ps1

# Handle npm and yarn tasks for front-end
Set-Location ./html
npm install -g corepack
corepack enable
corepack prepare yarn@stable --activate
yarn install
yarn run check
yarn run build
Set-Location ..
if ($IsWindows) {
    # Install necessary dependencies and build libwebsockets
    Set-Location ./external/libwebsockets
    & "C:\msys64\msys2_shell.cmd" -here -no-start -defterm -ucrt64 -c "pacman -S --noconfirm base-devel subversion mingw-w64-ucrt-x86_64-gcc mingw-w64-ucrt-x86_64-cmake mingw-w64-ucrt-x86_64-zlib mingw-w64-ucrt-x86_64-libuv mingw-w64-ucrt-x86_64-mbedtls mingw-w64-ucrt-x86_64-json-c"
    & "C:\msys64\msys2_shell.cmd" -here -no-start -defterm -ucrt64 -c "./scripts/mingw-build.sh"
    Set-Location $env:SRC_DIR
    # Set up MinGW environment variables for Windows
    $env:NPM_CONFIG_PREFIX = "$env:BUILD_PREFIX"
    $cmakeArgs += @(
        "-DCMAKE_PREFIX_PATH=C:/msys64/mingw64;$env:CMAKE_PREFIX_PATH"
        "-DCMAKE_C_COMPILER=x86_64-w64-mingw32-gcc"
        "-DCMAKE_CXX_COMPILER=x86_64-w64-mingw32-g++"
        "-DCMAKE_FIND_LIBRARY_SUFFIXES=.a"
        "-DCMAKE_EXE_LINKER_FLAGS=-static -no-pie -Wl,-s -Wl,-Bsymbolic -Wl,--gc-sections"
    )
}
else {
    # Final CMake install step
    cmake -S . -B build @cmakeArgs
    cmake --build build --config Release --target install
}

