Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

Remove-Item $ROOT/temp/$name -Recurse -ErrorAction SilentlyContinue
New-Item $ROOT/temp/$name -ItemType Directory
aria2c -c -x16 -s16 -d "$ROOT/temp/$name/" `
    "https://nssm.cc/release/nssm-2.24.zip" `
    -o "$name.zip"

7z x "$ROOT/temp/$name/$name.zip" "-o$ROOT/temp/$name/$name"

build-pkg