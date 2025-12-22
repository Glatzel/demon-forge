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

build-cargo-package-github $name "https://github.com/zed-industries/$name.git" "v$latest_version" zed
build-cargo-package-github $name "https://github.com/zed-industries/$name.git" "v$latest_version" cli
build-pkg
