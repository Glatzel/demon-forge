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
    Copy-Item $env:RECIPE_DIR/PKGBUILD ./external/libwebsockets
    Copy-Item $env:RECIPE_DIR/mingw-build.sh ./scripts/mingw-build.sh
    Get-ChildItem -Recurse -File | ForEach-Object {
        $c = Get-Content $_.FullName -Raw
        if ($c -match "`r`n") {
            $c -replace "`r`n", "`n" | Set-Content $_.FullName -NoNewline
        }
    }
    & "C:\msys64\msys2_shell.cmd" -here -no-start -defterm -ucrt64 -c "./scripts/mingw-build.sh"
    New-Item $env:PREFIX/bin -ItemType Directory
    Copy-Item ./build/ttyd.exe $env:PREFIX/bin
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
