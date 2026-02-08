Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
$latest_version = curl "https://dist.$name.org/index.json" | jq '.artifacts[0].versions[0].version'
$latest_version = "$latest_version".Replace("""", "")
update-recipe -version $latest_version

