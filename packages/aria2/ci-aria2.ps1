Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
$latest_version = get-version-github -repo "$name/$name"
$latest_version = "$latest_version".Replace("release-", "")
dispatch-workflow -version $latest_version
