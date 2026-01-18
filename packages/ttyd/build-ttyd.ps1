$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
copy-item $PSScriptRoot/build/* ./ -recurse
get-content ./index.scss >> ./html/src/style/index.scss
function build_libwebsockets {
    $repoUrl = 'https://github.com/msys2/MINGW-packages/trunk/mingw-w64-libwebsockets'
    $pkgDir  = 'mingw-w64-libwebsockets'
    $pkgbuild = Join-Path $pkgDir 'PKGBUILD'

    # Checkout PKGBUILD
    svn co $repoUrl

    # Replace openssl -> mbedtls
    (Get-Content $pkgbuild) `
        -replace 'openssl', 'mbedtls' |
        Set-Content $pkgbuild

    # Insert CMake options after CMAKE_INSTALL_PREFIX line
    $lines = Get-Content $pkgbuild
    $out = foreach ($line in $lines) {
        $line
        if ($line -match '-DCMAKE_INSTALL_PREFIX=\$\{MINGW_PREFIX\}') {
            '    -DLWS_WITH_MBEDTLS=ON \'
            '    -DLWS_WITH_LIBUV=ON \'
        }
    }
    $out | Set-Content $pkgbuild

    Push-Location $pkgDir
    try {
        & C:/msys64/usr/bin/makepkg-mingw.exe --cleanbuild --syncdeps --force --noconfirm
        & C:/msys64/usr/bin/pacman.exe -U *.pkg.tar.zst --noconfirm
    }
    finally {
        Pop-Location
    }
}

if ($IsWindows) {
    $env:NPM_CONFIG_PREFIX = "$env:BUILD_PREFIX"
    & C:/msys64/usr/bin/pacman.exe -S --noconfirm mingw-w64-x86_64-json-c
    copy-item C:/msys64/mingw64/* $env:BUILD_PREFIX/Library -Recurse -force
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
