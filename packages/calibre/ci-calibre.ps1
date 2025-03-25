Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
$name = get-name

$current_version = get-current-version
Write-Output "Current Version: $current_version"

$latest_version = get-latest-version -repo "https://github.com/kovidgoyal/$name"
$latest_version = "$latest_version".Replace("v", "")
Write-Output "Latest Version: $latest_version"
Remove-Item $ROOT/temp/$name -Recurse -ErrorAction SilentlyContinue
New-Item  $ROOT/temp/$name -ItemType Directory
gh release download -R https://github.com/kovidgoyal/$name -p "$name-portable*" `
    -O  $ROOT/temp/$name/$name.exe --clobber
Start-Process -FilePath "$ROOT/temp/$name/$name.exe" -ArgumentList "$ROOT/temp/$name/$name" -Wait
update-recipe -version $latest_version
build-pkg
