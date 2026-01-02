Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
$version = get-current-version
Set-Location $env:SRC_DIR
New-Item $env:PREFIX/bin -ItemType Directory
#download icon
if ($IsWindows) {
    aria2c -c -x16 -s16 -d "$ROOT/temp/$name/" `
        "https://raw.githubusercontent.com/zed-industries/zed/refs/tags/v$version/crates/zed/resources/windows/app-icon.ico" `
        -o "$name.ico"
}

# enable long path
if ($IsWindows) {
    git config --system core.longpaths true
    New-ItemProperty `
        -Path "HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem" `
        -Name "LongPathsEnabled" `
        -PropertyType DWord `
        -Value 1 `
        -Force
}

if ($env:DIST_BUILD) {
    cargo build -r --package zed --package cli
}
else {
    cargo build --package zed --package cli
}

if ($env:DIST_BUILD) {
    $build_profile = 'release'
}
else {
    $build_profile = 'debug'
}

Copy-Item "./target/$build_profile/zed.exe" "$env:PREFIX/bin/zed.exe"
Copy-Item "./target/$build_profile/cli.exe" "$env:PREFIX/bin/zed-cli.exe"
# shortcut
New-Item $env:PREFIX/Menu -ItemType Directory
Copy-Item "$env:RECIPE_DIR/$name.json" "$env:PREFIX/Menu"
if ($IsWindows) {
    Copy-Item "$ROOT/temp/$name/$name.ico" "$env:PREFIX/Menu"
}
