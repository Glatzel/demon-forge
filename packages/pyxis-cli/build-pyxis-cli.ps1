Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

New-Item $env:PREFIX/bin -ItemType Directory
if ($env:DIST_BUILD) {
    $config = "release"
}
else {
    $config = "debug"
}
if ($IsWindows) {
    Copy-Item $$ROOT/temp/$name/pyxis/rust/target/$config/pyxis.exe "$env:PREFIX/bin/"
}
else {
    Copy-Item $$ROOT/temp/$name/pyxis/rust/target/$config/pyxis "$env:PREFIX/pyxis/bin/"
}
