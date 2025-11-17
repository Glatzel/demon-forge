Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
Remove-Item $ROOT/temp/$name -Recurse -ErrorAction SilentlyContinue
$xml = [xml](Invoke-WebRequest -UseBasicParsing -Uri "https://www.kisssub.org/rss-bitcomet.xml").Content
$latest = $xml.rss.channel.item[0]
$title = $latest.title.'#cdata-section'
$guid = $latest.guid.'#text'

if ($title -match 'build (\d+\.\d+\.\d+\.\d+)') {
    $latest_version = $matches[1]
}
update-recipe -version $latest_version

if ($guid -match 'show-([0-9a-f]+)\.html$') {
    $guidHash = $matches[1]
    Write-Host $guidHash
    $magnet = 'magnet:?xt=urn:btih:' + $guidHash
}
$trackerList = (Invoke-WebRequest -UseBasicParsing -Uri 'http://github.itzmx.com/1265578519/OpenTracker/master/tracker.txt').Content
$trackers = ($trackerList -split '\s+') -join ','
aria2c --seed-time=0 --bt-tracker="$trackers" --dir "$ROOT/temp/$name" "$magnet"
$zipfile = (Get-ChildItem "$ROOT/temp/$name/*.7z")[0]
7z x "$zipfile" "-o$ROOT/temp/$name/$name"
$folder = (Get-ChildItem "$ROOT/temp/$name/$name/*" -Directory)[0]
Rename-Item $folder bitcomet
build-pkg
