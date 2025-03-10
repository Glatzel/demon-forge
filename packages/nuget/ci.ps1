Set-Location $PSScriptRoot
. ../../scripts/setup.ps1

$current_version = get-current-version
Write-Output "Current Version: $current_version"

$latest_version = curl https://dist.nuget.org/index.json | jq '.artifacts[0].versions[0].version'
$latest_version = "$latest_version".Replace("""","")

Remove-Item ../../temp/nuget -Recurse -ErrorAction SilentlyContinue
New-Item ../../temp/nuget -ItemType Directory
aria2c -c -x16 -s16 -d ../../temp/nuget/ "https://dist.nuget.org/win-x86-commandline/latest/nuget.exe" `
    -o nuget.exe
Write-Output "Latest Version: $latest_version"

update-recipe -version $latest_version
build_pkg
test_pkg