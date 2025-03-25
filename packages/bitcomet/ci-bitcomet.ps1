Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
$name = get-name

Remove-Item $ROOT/temp/$name -Recurse -ErrorAction SilentlyContinue
New-Item $ROOT/temp/$name -ItemType Directory
aria2c --dir="$ROOT/temp/$name/" `
    --bt-max-peers=0 `
    --seed-time=0 `
    --enable-dht=true `
    --seed-ratio=0 `
    --bt-request-peer-speed-limit=50M `
    --user-agent=Transmission/2.92 `
    "bitcomet.torrent" 

foreach ($f in Get-ChildItem $ROOT/temp/$name/*.7z) {
    7z x "$f" "-o$ROOT/temp/$name/"
}

build-pkg
