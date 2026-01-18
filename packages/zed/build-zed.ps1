$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

New-Item $env:PREFIX/Menu -ItemType Directory
Copy-Item "$env:PREFIX/$name.json" "$env:PREFIX/Menu"
if ($IsWindows) {
    aria2c -c -x16 -s16 -d "$env:PREFIX/Menu" `
        "https://raw.githubusercontent.com/zed-industries/zed/refs/tags/v${env:PKG_VERSION}/crates/zed/resources/windows/app-icon.ico" `
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
$env:CARGO_TARGET_DIR = "$env:SRC_DIR/target"
cargo install --root $env:PREFIX --path ./crates/zed
cargo install --root $env:PREFIX --path ./crates/cli
Rename-Item $env:PREFIX/bin/cli.exe $env:PREFIX/bin/zed-cli.exe
