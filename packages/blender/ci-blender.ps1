Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
$repoUrl = "https://github.com/$name/$name.git"
$latestTag = git ls-remote --tags $repoUrl | Where-Object { $_ -match "refs/tags/v\d+.\d+.\d+" } | ForEach-Object { $_ -replace '^.*refs/tags/v(.*)$', '$1' }| Select-Object -Last 1
$latest_version = [Version]"$latestTag"
update-recipe -version $latest_version

