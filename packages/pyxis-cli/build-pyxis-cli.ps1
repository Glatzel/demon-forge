Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

New-Item $env:PREFIX/bin -ItemType Directory
if ($IsWindows) {
    Copy-Item $ROOT/temp/$name/pyxis/rust/target/release/pyxis.exe "$env:PREFIX/bin/"
}
else {
    Copy-Item $ROOT/temp/$name/pyxis/rust/target/release/pyxis "$env:PREFIX/bin/"
}
