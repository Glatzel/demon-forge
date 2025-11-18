Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

$latest_version = get-version-url -url "https://filezilla-project.org/newsfeed.php" -pattern 'FileZilla Client (\d+\.\d+\.\d+) released'
update-recipe -version $latest_version

Remove-Item $ROOT/temp/$name -Recurse -ErrorAction SilentlyContinue
New-Item $ROOT/temp/$name -ItemType Directory
pixi run -e selenium python download.py

$zipfile = (Get-ChildItem "$ROOT/temp/$name/FileZilla*win64.zip")[0]
7z x "$zipfile" "-o$ROOT/temp/$name"

update-recipe -version $latest_version
build-pkg
