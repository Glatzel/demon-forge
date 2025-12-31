Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

$version = get-current-version
if ($IsWindows) {
    $env:PATH = "$env:BUILD_PREFIX/bin;$env:PATH"
}
if ($IsLinux) {
    $env:PATH = "$env:BUILD_PREFIX/bin`:$env:PATH"
}
New-Item $env:PREFIX/bin -ItemType Directory
Set-Location $ROOT/temp/$name
git clone https://github.com/tsl0922/ttyd.git
Set-Location $name

git checkout tags/$version -b "branch-$version"
copy-item $PSScriptRoot/build/* $ROOT/temp/$name/$name -recurse
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

if ($IsWindows) {

}
if ($IsLinux) {
    mkdir build
    Set-Location build
    cmake ..
    make
    make PREFIX=$env:PREFIX install
}
