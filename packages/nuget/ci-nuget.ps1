Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
$name=get-name

$latest_version = curl "https://dist.$name.org/index.json" | jq '.artifacts[0].versions[0].version'
$latest_version = "$latest_version".Replace("""", "")

Remove-Item $ROOT/temp/nuget -Recurse -ErrorAction SilentlyContinue
New-Item $ROOT/temp/$name -ItemType Directory
aria2c -c -x16 -s16 -d "$ROOT/temp/$name/" `
    "https://dist.$name.org/win-x86-commandline/latest/$name.exe" `
    -o "$name.exe"

update-recipe -version $latest_version
build-pkg
