Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
$name = get-name

Remove-Item $ROOT/temp/$name -Recurse -ErrorAction SilentlyContinue
New-Item $ROOT/temp/$name -ItemType Directory
pixi run -e selenium python download.py

$zipfile=(Get-ChildItem "$ROOT/temp/$name/*.zip")[0]
7z x "$zipfile" "-o$ROOT/temp/$name"
$zipfile.BaseName -match "ImageMagick-(\d+\.\d+\.\d+-\d+)-portable-Q16-HDRI-x64"
$latest_version=$Matches[1]
$latest_version="$latest_version".Replace("-",".")
update-recipe -version $latest_version
build-pkg
