Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
$latest_version = get-version-github -repo "containernetworking/plugins"
update-recipe -version $latest_version
if ($IsWindows) {
    gh release download -R "containernetworking/plugins" -p "$name-windows-amd64-*.tgz" `
        -O  $ROOT/temp/$name/$name.tgz --clobber
}
if ($IsLinux -and $arch -eq "X64") {
    gh release download -R "containernetworking/plugins" -p "$name-linux-amd64-*.tgz" `
        -O  $ROOT/temp/$name/$nam.tgz --clobber
}
if ($IsLinux -and $arch -eq "Arm64") {
    gh release download -R "containernetworking/plugins" -p "$name-linux-arm64.tgz" `
        -O  $ROOT/temp/$name/$name.tgz --clobber
}
7z x $ROOT/temp/$name/$name.tgz "-o$ROOT/temp/$name/"
7z x $ROOT/temp/$name/$name.tar "-o$ROOT/temp/$name/$name"
build-pkg
