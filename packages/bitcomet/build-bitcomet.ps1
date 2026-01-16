$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1


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
aria2c --seed-time=0 --bt-tracker="$trackers" --dir "." "$magnet"
$zipfile = (Get-ChildItem "./*.7z")[0]
7z x "$zipfile" "-o./$name"
$folder = (Get-ChildItem "./$name/*" -Directory)[0]
Rename-Item $folder bitcomet
New-Item $env:PREFIX/bin/$name -ItemType Directory
Copy-Item "./$name/$name/$name/*" "$env:PREFIX/bin/$name" -Recurse

# shortcut
New-Item $env:PREFIX/Menu -ItemType Directory
Copy-Item "$name.json" "$env:PREFIX/Menu"
