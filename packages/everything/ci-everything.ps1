Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
$name = get-name

$current_version = get-current-version
Write-Output "Current Version: $current_version"

Remove-Item $ROOT/temp/$name -Recurse -ErrorAction SilentlyContinue
New-Item $ROOT/temp/$name -ItemType Directory
pixi run -e selenium python download.py

$zipfile=(Get-ChildItem "$ROOT/temp/$name/*.zip")[0]
7z x "$zipfile" "-o$ROOT/temp/$name"
$zipfile.BaseName -match "Everything-(\S+).x64"
$latest_version=$Matches[1]
Write-Output "Latest Version: $latest_version"
update-recipe -version $latest_version
build-pkg
