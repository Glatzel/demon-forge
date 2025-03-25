Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
$name = get-name

Remove-Item $ROOT/temp/$name -Recurse -ErrorAction SilentlyContinue
New-Item $ROOT/temp/$name -ItemType Directory
aria2c --dir="$ROOT/temp/$name/" `
     "magnet:?xt=urn:btih:658d6ea885e14a443ff65c23adf66328fd0cb0cb&tr=http://open.acgtracker.com:1096/announce" `
    --seed-time=0

foreach ($f in Get-ChildItem $ROOT/temp/$name/*.7z) {
    7z x "$f" "-o$ROOT/temp/$name/"
}

build-pkg
