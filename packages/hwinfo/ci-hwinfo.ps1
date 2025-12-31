Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
$latest_version = get-version-url -url "https://www.hwinfo.com/news.xml/" -pattern 'HWiNFO v(\d+\.\d+) released'
update-recipe -version $latest_version
build-pkg
