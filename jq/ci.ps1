Set-Location $PSScriptRoot
. ../scripts/setup.ps1

$current_version = get-current-version
Write-Output "Current Version: $current_version"

$latest_version = get_latest_version -repo "jqlang/jq"
$latest_version = "$latest_version".Replace("jq-", "")
Write-Output "Latest Version: $latest_version"

gh release download -R jqlang/jq -p "jq-windows-amd64.exe" -O jq.exe --clobber
update-recipe -version $latest_version
build_pkg
test_pkg
