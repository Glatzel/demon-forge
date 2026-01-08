Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
$latest_version = get-version-github -repo "tsl0922/$name"
update-recipe -version $latest_version

build-pkg
if ($IsLinux -and $arch -eq 'X64') {
    pixi global install --environment build-ttyd `
        brotlipy  `
        cmake=3.* `
        fonttools `
        make `
        nodejs `
        pkg-config `
        c-compiler `
        cxx-compiler `
        autoconf `
        automake `
        file
    Get-ChildItem $env:USERPROFILE/.pixi/bin
    $env:NPM_CONFIG_PREFIX = "$env:USERPROFILE/.pixi/envs/build-ttyd"
    Set-Location $ROOT/temp/$name
    git clone https://github.com/tsl0922/ttyd.git
    Set-Location $name
    git checkout tags/"$latest_version" -b "$latest_version-branch"
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
    dnf update -y
    dnf install -y gcc gcc-c++ cmake make automake autoconf file libtool curl

    $env:BUILD_TARGET = "win32"
    & bash ./scripts/cross-build.sh
    build-pkg --target_platform 'win-64'
}
