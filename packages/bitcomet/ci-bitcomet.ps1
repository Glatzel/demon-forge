Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
$latest_version = get-version-url -url "https://www.kisssub.org/rss-bitcomet.xml" -pattern 'build (\d+\.\d+\.\d+\.\d+)'
dispatch-workflow $latest_version
