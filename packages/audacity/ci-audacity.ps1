Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
$latest_version = get-version-github -repo "https://github.com/$name/$name"
$latest_version = "$latest_version".Replace("Audacity-", "")
update-recipe -version $latest_version
build-pkg
