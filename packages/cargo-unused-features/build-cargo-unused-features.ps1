Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
build-cargo-package $name $name
if ($IsWindows) {
    Rename-Item $env:PREFIX/bin/unused-features.exe $env:PREFIX/bin/$name.exe
}
else {
    Rename-Item $env:PREFIX/bin/unused-features $env:PREFIX/bin/$name
}
