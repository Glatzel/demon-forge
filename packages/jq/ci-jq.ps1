Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
$latest_version = get-version-github -repo "jqlang/$name"
$latest_version = "$latest_version".Replace("$name-", "")
update-recipe -version $latest_version
