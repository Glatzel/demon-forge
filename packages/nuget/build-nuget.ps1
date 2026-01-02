Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
aria2c -c -x16 -s16 -d "$ROOT/temp/$name/" `
    "https://dist.$name.org/win-x86-commandline/latest/$name.exe" `
    -o "$name.exe"
New-Item $env:PREFIX/bin -ItemType Directory
Copy-Item "$ROOT/temp/$name/$name.exe" "$env:PREFIX/bin/$name.exe"
