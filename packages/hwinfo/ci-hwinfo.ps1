Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1


Remove-Item $ROOT/temp/$name -Recurse -ErrorAction SilentlyContinue
New-Item $ROOT/temp/$name -ItemType Directory
pixi run -e selenium python download.py

$zipfile = (Get-ChildItem "$ROOT/temp/$name/hwi_*.zip")[0]
7z x "$zipfile" "-o$ROOT/temp/$name/$name"
$latest_version = (Get-Item $ROOT/temp/$name/$name/HWiNFO64.exe).VersionInfo.ProductVersion.Split("-")[0]

update-recipe -version $latest_version
build-pkg
