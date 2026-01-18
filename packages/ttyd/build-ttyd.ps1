$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
copy-item $PSScriptRoot/build/* ./ -recurse
get-content ./index.scss >> ./html/src/style/index.scss
& ./download-font.ps1

Set-Location ./html
if ($IsWindows) {
    $env:NPM_CONFIG_PREFIX = "$env:BUILD_PREFIX"
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

cmake `
    -DCMAKE_INSTALL_PREFIX="$env:PREFIX" `
    -DCMAKE_BUILD_TYPE="RELEASE" `
    ..

cmake --build . --config Release --target install
