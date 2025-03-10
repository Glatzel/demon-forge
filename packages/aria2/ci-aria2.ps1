Set-Location $PSScriptRoot
. ../../scripts/setup.ps1

$current_version = get-current-version
Write-Output "Current Version: $current_version"

$latest_version = get_latest_version -repo "aria2/aria2"
$latest_version = "$latest_version".Replace("release-", "")
Write-Output "Latest Version: $latest_version"

Remove-Item ../../temp/aria2 -Recurse -ErrorAction SilentlyContinue
New-Item  ../../temp/aria2 -ItemType Directory
gh release download -R aria2/aria2 -p "aria2-*-win-64bit*.zip" `
    -O  ../../temp/aria2/aria2.zip --clobber
Expand-Archive ../../temp/aria2/aria2.zip ../../temp/aria2/
update-recipe -version $latest_version
build_pkg
test_pkg
