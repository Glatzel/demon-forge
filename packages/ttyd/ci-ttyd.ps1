Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
$latest_version = get-version-github -repo "tsl0922/$name"
update-recipe -version $latest_version

Set-Location $ROOT/temp/$name
git clone https://github.com/tsl0922/ttyd.git
Set-Location $name
git checkout tags/"$latest_version" -b "$latest_version-branch"
copy-item $PSScriptRoot/build/* $ROOT/temp/$name/$name -recurse
git apply config.patch
get-content ./index.scss >> ./html/src/style/index.scss

write-output "::group::font"
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

foreach ($t in "win32", "x86_64", "aarch64") {
    Write-Output "::group::compile $t"
    $env:BUILD_TARGET = $t
    & bash ./scripts/cross-build.sh
    Write-Output "::endgroup::"

    Write-Output "::group::compile $t"
    Set-Location $PSScriptRoot
    switch ($t) {
        "win32" {
            $env:TARGET_PLATFORM = 'win-64'
            pixi run rattler-build build --target-platform 'win-64'
        }
        "x86_64" {
            $env:TARGET_PLATFORM = 'linux-64'
            pixi run rattler-build build --target-platform 'linux-64'
        }
        "aarch64" {
            $env:TARGET_PLATFORM = 'linux-aarch64'
            pixi run rattler-build build --target-platform 'linux-aarch64'
        }
    }
    Set-Location $ROOT/temp/$name/$name
    Write-Output "::endgroup::"
}
