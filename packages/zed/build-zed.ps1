Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

New-Item $env:PREFIX/Menu -ItemType Directory
Copy-Item "$name.json" "$env:PREFIX/Menu"
if ($IsWindows) {
    $version = get-current-version
    aria2c -c -x16 -s16 -d "$env:PREFIX/Menu" `
        "https://raw.githubusercontent.com/zed-industries/zed/refs/tags/v$version/crates/zed/resources/windows/app-icon.ico" `
        -o "$name.ico"
}

Set-Location $env:SRC_DIR
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
cargo build -r --package zed
# $env:CARGO_TARGET_DIR="$env:SRC_DIR/target"
# cargo install --root $env:PREFIX --path ./crates/zed
# cargo install --root $env:PREFIX --path ./crates/cli
# Rename-Item $env:PREFIX/bin/cli.exe $env:PREFIX/bin/zed-cli.exe
