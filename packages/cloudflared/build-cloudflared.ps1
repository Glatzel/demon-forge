Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

New-Item $env:PREFIX/bin -ItemType Directory
if ($IsWindows) {
    Copy-Item "$ROOT/temp/$name/$name.exe" "$env:PREFIX/bin/$name.exe"
}
else {
    Copy-Item "$ROOT/temp/$name/$name" "$env:PREFIX/bin/$name"
}
if ($IsLinux) {
    Copy-Item "$ROOT/temp/$name/$name" "$env:PREFIX/bin/$name"
    chmod +rwx "$env:PREFIX/bin/$name"
}