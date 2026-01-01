Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
aria2c -c -x16 -s16 -d "$ROOT/temp/$name/" `
    "https://googledownloads.cn/android/repository/platform-tools-latest-windows.zip" `
    -o "$name.zip"
7z x "$ROOT/temp/$name/$name.zip" "-o$ROOT/temp/$name"
New-Item $env:PREFIX/bin -ItemType Directory
Copy-Item "$ROOT/temp/$name/platform-tools/*" "$env:PREFIX/bin" -recurse
