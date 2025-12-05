Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
$latest_version = get-version-github -repo "$name/$name"
update-recipe -version $latest_version
if ($IsWindows) {
    gh release download -R "$name/$name" -p "$name-*-windows-amd64.tar.gz" `
        -O  $ROOT/temp/$name/$name.tar.gz --clobber
}
if ($IsLinux -and $arch -eq "X64") {
    gh release download -R "$name/$name" -p "$name-static-*.*.*-linux-amd64.tar.gz" `
        -O  $ROOT/temp/$name/$name.tar.gz --clobber
}
if ($IsLinux -and $arch -eq "Arm64") {
    gh release download -R "$name/$name" -p "$name-static-*.*.*-linux-arm64.tar.gz" `
        -O  $ROOT/temp/$name/$name.tar.gz --clobber
}
7z x $ROOT/temp/$name/$name.tar.gz "-o$ROOT/temp/$name/"
7z x $ROOT/temp/$name/$name.tar "-o$ROOT/temp/$name/$name"

build-pkg
