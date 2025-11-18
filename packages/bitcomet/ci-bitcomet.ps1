Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
$latest_version = get-version-url -url "https://www.kisssub.org/rss-bitcomet.xml" -pattern 'build (\d+\.\d+\.\d+\.\d+)'
update-recipe -version $latest_version
create-temp -name $name
$xml = [xml](Invoke-WebRequest -UseBasicParsing -Uri "https://www.kisssub.org/rss-bitcomet.xml").Content
$latest = $xml.rss.channel.item[0]
$guid = $latest.guid.'#text'
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
