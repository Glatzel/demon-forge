Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
$xml = [xml](Invoke-WebRequest -UseBasicParsing -Uri "https://www.kisssub.org/rss-bitcomet.xml").Content
$latest = $xml.rss.channel.item[0]
$title = $latest.title.'#cdata-section'
$guid = $latest.guid.'#text'

if ($title -match 'build (\d+\.\d+\.\d+\.\d+)') {
    $latest_version = $matches[1]
}

if ($guid -match 'show-([0-9a-f]+)\.html$') {
    $guidHash = $matches[1]
    Write-Host $guidHash
    $magnet = 'magnet:?xt=urn:btih:' + $guidHash
}
aria2c --seed-time=0 --dir "$ROOT/$name" "$magnet"

update-recipe -version $latest_version
build-pkg
