Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
$latest_version = get-version-github "zed-industries/$name"
update-recipe -version $latest_version

if($IsWindows){
    git config --system core.longpaths true
    New-ItemProperty `
      -Path "HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem" `
      -Name "LongPathsEnabled" `
      -PropertyType DWord `
      -Value 1 `
      -Force
}
cd $ROOT/temp/$name
git clone https://github.com/zed-industries/zed.git
cd zed
if ($env:DIST_BUILD){
    cargo build -r
    ls ./target/release
}
else{
    cargo build
    ls ./target/debug
}
# build-pkg
