Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
$latest_version = get-version-github "zed-industries/$name"
update-recipe -version $latest_version

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
if ($env:DIST_BUILD) {
    cargo build -r --package zed --package cli
}
else {
    cargo build --package zed --package cli
}
Set-Location $PSScriptRoot
build-pkg
