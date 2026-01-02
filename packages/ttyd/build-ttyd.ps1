Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

copy-item $PSScriptRoot/build/* $env:SRC_DIR/temp/$name/$name -recurse
git apply config.patch
get-content ./index.scss >> ./html/src/style/index.scss
& ./download-font.ps1

Set-Location ./html

npm install -g corepack
corepack enable
corepack prepare yarn@stable --activate
yarn install
yarn run check
yarn run build
Set-Location ..
mkdir build
Set-Location build

if ($IsLinux) {
    cmake `
        -DCMAKE_INSTALL_PREFIX="$env:PREFIX" `
        -DCMAKE_BUILD_TYPE="RELEASE" `
        ..
}

cmake --build . --config Release --target install
