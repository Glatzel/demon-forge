Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
$latest_version = get-version-url -url "https://filezilla-project.org/newsfeed.php" -pattern 'FileZilla Client (\d+\.\d+\.\d+) released'
update-recipe -version $latest_version

pixi run -e selenium python download.py

$zipfile = (Get-ChildItem "$ROOT/temp/$name/FileZilla*win64.zip")[0]
7z x "$zipfile" "-o$ROOT/temp/$name"
ls $ROOT/temp/$name/Filezilla*
update-recipe -version $latest_version
build-pkg
