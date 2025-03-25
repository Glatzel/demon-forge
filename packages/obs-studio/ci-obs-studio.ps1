Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
$name = get-name

$current_version = get-current-version
Write-Output "Current Version: $current_version"

$latest_version = get-latest-version -repo "https://github.com/obsproject/$name"
Write-Output "Latest Version: $latest_version"
Remove-Item $ROOT/temp/$name -Recurse -ErrorAction SilentlyContinue
New-Item  $ROOT/temp/$name -ItemType Directory
gh release download -R https://github.com/obsproject/$name -p "*-Windows.zip" `
    -O  $ROOT/temp/$name/$name.zip --clobber
7z x "$ROOT/temp/$name/$name.zip" "-o$ROOT/temp/$name/$name"
update-recipe -version $latest_version
build-pkg
