Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
$name = get-name

Remove-Item $ROOT/temp/$name -Recurse -ErrorAction SilentlyContinue
New-Item $ROOT/temp/$name -ItemType Directory
pixi run -e selenium python download.py

$zipfile=(Get-ChildItem "$ROOT/temp/$name/FileZilla*win64.zip")[0]
7z x "$zipfile" "-o$ROOT/temp/$name"
$zipfile.BaseName -match "FileZilla_(\S+)_win64"
$latest_version=$Matches[1]

update-recipe -version $latest_version
build-pkg
