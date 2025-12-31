Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
aria2c -c -x16 -s16 -d "$ROOT/temp/$name/" `
    "https://nssm.cc/release/nssm-$(get-current-version).zip" `
    -o "$name.zip"

7z x "$ROOT/temp/$name/$name.zip" "-o$ROOT/temp/$name/$name"
New-Item $env:PREFIX/bin -ItemType Directory
Copy-Item "$ROOT/temp/$name/$name/$name*/Win64/$name.exe" "$env:PREFIX/bin/$name.exe"
