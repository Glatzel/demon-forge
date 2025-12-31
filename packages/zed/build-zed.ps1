Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
$version = get-current-version
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
Set-Location $ROOT/temp/$name
git clone https://github.com/zed-industries/zed.git
Set-Location zed
git checkout tags/"v$version" -b "$version"
if ($IsWindows) {
    $cargo = "$env:BUILD_PREFIX/Library/bin/cargo.exe"
}
else {
    $cargo = "$env:BUILD_PREFIX/bin/cargo"
}

if ($env:DIST_BUILD) {
    & $cargo install -r --root $env:PREFIX -- --package zed --package cli
}
else {
    & $cargo install --root $env:PREFIX -- --package zed --package cli
}

# shortcut
New-Item $env:PREFIX/Menu -ItemType Directory
Copy-Item "$name.json" "$env:PREFIX/Menu"
if ($IsWindows) {
    Copy-Item "$ROOT/temp/$name/$name.ico" "$env:PREFIX/Menu"
}
