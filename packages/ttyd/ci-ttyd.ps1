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

write-output    "::group::font"
& ./download-font.ps1
Write-Output "::endgroup::"

write-output "::group::Run yarn install, check and build"
Set-Location ./html
pixi run corepack enable
pixi run corepack prepare yarn@stable --activate
pixi run yarn install
pixi run yarn run check
pixi run yarn run build
Write-Output "::endgroup::"

write-output "::group::Install packages"
Set-Location ..
sudo apt-get update
sudo apt-get install -y autoconf automake build-essential cmake curl file libtool
write-output  "::endgroup::"

foreach($t in "win32","x86_64","aarch64")
{
        Write-Output "::group::compile $t"
$env:BUILD_TARGET=$t
& bash ./scripts/cross-build.sh
        Write-Output "::endgroup::"
}
ls ./build
Set-Location $PSScriptRoot
foreach($t in "win-64","linux-64","linux-aarch64")
{
        Write-Output "::group::build $t"
$env:TARGET_platform=$t
pixi run rattler-build build --target-platform $t
        Write-Output "::endgroup::"
}
