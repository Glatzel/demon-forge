Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
$latest_version = get-version-github -repo "Glatzel/$name"
update-recipe -version $latest_version

Set-Location $ROOT/temp/$name
git clone https://github.com/tsl0922/ttyd.git
Set-Location $name
git checkout tags/"$latest_version" -b "$latest_version-branch"
copy-item $PSScriptRoot/build/* $ROOT/temp/$name/$name -recurse
& $ROOT/temp/$name/download-font.ps1
pixi run corepack enable
pixi run corepack prepare yarn@stable --activate
pixi run yarn install
pixi run yarn run check
pixi run yarn run build
sudo apt-get update
sudo apt-get install -y autoconf automake build-essential cmake curl file libtool
foreach($t in "win32","x86_64","aarch64")
{
$env:BUILD_TARGET=$t
& bash ./scripts/cross-build.sh

}
ls ./build
Set-Location $PSScriptRoot
foreach($t in "win-64","linux-64","linux-aarch64")
{
$env:TARGET_platform=$t
pixi run rattler-build build --target-platform $t
}
