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
7z x "$zipfile" "-o./${env:PKG_NAME}"
$folder = (Get-ChildItem "./${env:PKG_NAME}/*" -Directory)[0]
Rename-Item $folder bitcomet
New-Item $env:PREFIX/bin/${env:PKG_NAME} -ItemType Directory
Copy-Item "./${env:PKG_NAME}/${env:PKG_NAME}/${env:PKG_NAME}/*" "$env:PREFIX/bin/${env:PKG_NAME}" -Recurse# shortcut
New-Item $env:PREFIX/Menu -ItemType Directory
Copy-Item "${env:PKG_NAME}.json" "$env:PREFIX/Menu"
