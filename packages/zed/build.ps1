$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

New-Item $env:PREFIX/Menu -ItemType Directory
Copy-Item "$env:RECIPE_DIR/$env:PKG_NAME.json" "$env:PREFIX/Menu"
if ($IsWindows) {
    copy-item "./crates/zed/resources/windows/app-icon.ico" "$env:PREFIX/Menu/$env:PKG_NAME.ico"
    git config --system core.longpaths true
    New-ItemProperty `
        -Path "HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem" `
        -Name "LongPathsEnabled" `
        -PropertyType DWord `
        -Value 1 `
        -Force
}
cargo install --path ./crates/zed @(Get-Cargo-Arg)
cargo install --path ./crates/cli @(Get-Cargo-Arg)
Rename-Item $env:PREFIX/bin/cli.exe $env:PREFIX/bin/zed-cli.exe
