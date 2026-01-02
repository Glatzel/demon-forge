Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

New-Item $env:PREFIX/bin -ItemType Directory

if ($env:DIST_BUILD) {
    $build_profile = 'release'
}
else {
    $build_profile = 'debug'
}

Copy-Item "$ROOT/temp/$name/$name/target/$build_profile/zed.exe" "$env:PREFIX/bin/zed.exe"
Copy-Item "$ROOT/temp/$name/$name/target/$build_profile/cli.exe" "$env:PREFIX/bin/zed-cli.exe"

# shortcut
New-Item $env:PREFIX/Menu -ItemType Directory
Copy-Item "$name.json" "$env:PREFIX/Menu"
if ($IsWindows) {
    Copy-Item "$ROOT/temp/$name/$name.ico" "$env:PREFIX/Menu"
}
