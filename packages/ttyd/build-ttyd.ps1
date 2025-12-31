Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
New-Item $env:PREFIX/bin -ItemType Directory
Set-Location $ROOT/temp/$name
git clone https://github.com/tsl0922/ttyd.git
Set-Location $name
git checkout tags/"$latest_version" -b "$latest_version-branch"
copy-item $PSScriptRoot/build/* $ROOT/temp/$name/$name -recurse
git apply config.patch
get-content ./index.scss >> ./html/src/style/index.scss

& ./download-font.ps1

Set-Location ./html
pixi run npm install -g corepack
pixi run corepack enable
pixi run corepack prepare yarn@stable --activate
pixi run yarn install
pixi run yarn run check
pixi run yarn run build
Set-Location ..

if ($IsWindows) {

}
if ($IsLinux -and $arch -eq 'X64') {
    $env:BUILD_TARGET = "x86_64"
     pixi run bash ./scripts/cross-build.sh
    pixi run rattler-build build
    copy-item $ROOT/temp/$name/$name/build/$name $env:PREFIX/bin/$name
}
if ($IsLinux -and $arch -eq 'Arm64') {
    $env:BUILD_TARGET =  "aarch64"
     pixi run bash ./scripts/cross-build.sh
    pixi run rattler-build build
    copy-item $ROOT/temp/$name/$name/build/$name $env:PREFIX/bin/$name
}
