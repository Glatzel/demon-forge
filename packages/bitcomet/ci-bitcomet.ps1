Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
$name = get-name

Remove-Item $ROOT/temp/$name -Recurse -ErrorAction SilentlyContinue
New-Item $ROOT/temp/$name -ItemType Directory
aria2c --dir="$ROOT/temp/$name/" `
    --bt-tracker="http://github.itzmx.com/1265578519/OpenTracker/master/tracker.txt" `
    "magnet:?xt=urn:btih:3ac8c8ba74ea297a13339369e1341be2464f0a72&tr=http://open.acgtracker.com:1096/announce" `
    seed-time=0

foreach ($f in Get-ChildItem $ROOT/temp/$name/*.7z) {
    7z x "$f" "-o$ROOT/temp/$name/"
}

build-pkg
