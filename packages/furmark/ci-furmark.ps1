Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

$latest_version = get-version-url -url "https://geeks3d.com/furmark/changelog/" -pattern 'version (\d+\.\d+\.\d+\.*\d*)'
update-recipe -version $latest_version

pixi run -e selenium python download.py

$zipfile = (Get-ChildItem "$ROOT/temp/$name/*.zip")[0]
7z x "$zipfile" "-o$ROOT/temp/$name"

build-pkg
