Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
Set-Location $env:SRC_DIR
copy-item $PSScriptRoot/build/* ./ -recurse
git apply --ignore-whitespace config.patch
get-content ./index.scss >> ./html/src/style/index.scss

if ($IsWindows) {
    New-Item $env:PREFIX/bin -ItemType Directory
    (Get-Content ./html/webpack.config.js -Raw) -replace "`r`n", "`n" | Set-Content ./html/webpack.config.js -NoNewline
    copy-item $PSScriptRoot/build-win.ps1 ./build-win.ps1
    docker run `
        -v "$env:SRC_DIR`:/work" `
        ghcr.io/glatzel/ghar-linux-release-cloud `
        pwsh -f "./build-win.ps1"
    copy-item $env:SRC_DIR/build/$name.exe $env:PREFIX/bin/$name.exe
}
else {
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
    cmake `
        -DCMAKE_INSTALL_PREFIX="$env:PREFIX" `
        -DCMAKE_BUILD_TYPE="RELEASE" `
        ..
    cmake --build . --config Release --target install
}
