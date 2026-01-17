Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
$latest_version = get-version-github "zed-industries/$name"
update-recipe -version $latest_version

Remove-Item $ROOT/temp/$name -Force -Recurse -ErrorAction SilentlyContinue
New-Item  $ROOT/temp/$name -ItemType Directory
#download icon
if ($IsWindows) {
    aria2c -c -x16 -s16 -d "$ROOT/temp/$name/" `
        "https://raw.githubusercontent.com/zed-industries/zed/refs/tags/v$latest_version/crates/zed/resources/windows/app-icon.ico" `
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
git checkout tags/"v$latest_version" -b "$latest_version-branch"
cargo build -r --package zed --package cli
Set-Location $PSScriptRoot
build-pkg
