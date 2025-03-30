Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
$name = get-name

Remove-Item $ROOT/temp/$name -Recurse -ErrorAction SilentlyContinue
New-Item $ROOT/temp/$name -ItemType Directory
$rss = curl -s "https://sourceforge.net/projects/crystaldiskinfo/rss?path=/"
if (-not ("$rss" -match '(https://[^<>]+/\d+\.\d+\.\d+/[^<>]+\.zip/download)')){
    Write-Output "No new version"
    exit 0
}
$url=$Matches[0]
aria2c -c -x16 -s16 -d "$ROOT/temp/$name/" `
    "$url" `
    -o "$name.zip"
$zipfile = (Get-ChildItem "$ROOT/temp/$name/*.zip")[0]

7z x "$zipfile" "-o$ROOT/temp/$name/$name"
$url -match "/(\d+.\d+.\d+)/"
$latest_version = $Matches[1]
$latest_version = "$latest_version".Replace("_", ".")
update-recipe -version $latest_version
build-pkg
