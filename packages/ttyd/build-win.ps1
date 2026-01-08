Set-Location $PSScriptRoot
pixi global install `
    brotlipy `
    fonttools `
    nodejs `
    pkg-config `
    make `
    c-compiler `
    cxx-compiler `
    autoconf `
    automake `
    file `
    cmake=3.*
Set-Location ./html
npm install -g corepack
corepack enable
corepack prepare yarn@stable --activate
yarn install
yarn run check
yarn run build
Set-Location ..
$env:BUILD_TARGET = "win32"
& bash ./scripts/cross-build.sh
