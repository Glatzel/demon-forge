Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
$name=get-name
$current_version = get-current-version
Write-Output "Current Version: $current_version"

$latest_version = curl https://dist.$name.org/index.json | jq '.artifacts[0].versions[0].version'
$latest_version = "$latest_version".Replace("""", "")

Remove-Item $ROOT/temp/nuget -Recurse -ErrorAction SilentlyContinue
New-Item $ROOT/temp/$name -ItemType Directory
aria2c -c -x16 -s16 -d "$ROOT/temp/$name/" `
    "https://dist.$name.org/win-x86-commandline/latest/$name.exe" `
    -o "$name.exe"
Write-Output "Latest Version: $latest_version"

update-recipe -version $latest_version
build-pkg
