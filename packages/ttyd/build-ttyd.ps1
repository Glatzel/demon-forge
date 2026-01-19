$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
copy-item $PSScriptRoot/build/* ./ -recurse
get-content ./index.scss >> ./html/src/style/index.scss

# Common CMake options
$cmakeArgs = @(
    "-DVERBOSE=ON"
    "-DCMAKE_BUILD_TYPE=Release"
)

if ($IsWindows) {
    # Install necessary dependencies and build libwebsockets
    Set-Location ./external/libwebsockets
    Copy-Item $env:RECIPE_DIR/PKGBUILD ./
    Get-ChildItem -Recurse -File | ForEach-Object {
        $c = Get-Content $_.FullName -Raw
        if ($c -match "`r`n") {
            $c -replace "`r`n", "`n" | Set-Content $_.FullName -NoNewline
        }
    }
    & "C:\msys64\msys2_shell.cmd" -here -no-start -defterm -mingw64 -c "pacman -S --noconfirm mingw-w64-x86_64-json-c"
    & "C:\msys64\msys2_shell.cmd" -here -no-start -defterm -mingw64 -c "pacman -S --noconfirm binutils && makepkg --noconfirm -s && pacman --noconfirm -U *.pkg.tar.zst"
    Set-Location $env:SRC_DIR
    # Set up MinGW environment variables for Windows
    $env:NPM_CONFIG_PREFIX = "$env:BUILD_PREFIX"
    $cmakeArgs += @(
        "-G"
        "Ninja"
        "-DCMAKE_INSTALL_PREFIX=$env:PREFIX/Library"
        "-DCMAKE_PREFIX_PATH=C:/msys64/mingw64;$env:CMAKE_PREFIX_PATH"
        "-DCMAKE_C_COMPILER=x86_64-w64-mingw32-gcc"
        "-DCMAKE_CXX_COMPILER=x86_64-w64-mingw32-g++"
        "-DCMAKE_FIND_LIBRARY_SUFFIXES=.a"
    )
}
else {
    $cmakeArgs += @("-DCMAKE_INSTALL_PREFIX=$env:PREFIX")
}

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

# Final CMake install step
cmake -S . -B build @cmakeArgs
cmake --build build --config Release --target install
