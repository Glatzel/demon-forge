Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
$latest_version = get-version-url -url "https://www.intrsio.com/producterDownload/producterDownloadIndex.do" -pattern '版本：(\d+\.\d+\.\d+\.\d+)'
dispatch-workflow -version $latest_version
