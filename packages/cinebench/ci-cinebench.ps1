Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
$name = get-name

Remove-Item $ROOT/temp/$name -Recurse -ErrorAction SilentlyContinue
New-Item $ROOT/temp/$name -ItemType Directory
pixi run -e selenium python download.py

$zipfile=(Get-ChildItem "$ROOT/temp/$name/*.zip")[0]
7z x "$zipfile" "-o$ROOT/temp/$name/$name"
$zipfile.BaseName -match "Cinebench(\S+)_win_x84_64"
$latest_version=$Matches[1]

update-recipe -version $latest_version
build-pkg
