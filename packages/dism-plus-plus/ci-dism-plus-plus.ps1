Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1


$latest_version = get-version-github -repo "Chuyu-Team/Dism-Multi-language"
update-recipe -version $latest_version

Remove-Item $ROOT/temp/$name -Recurse -ErrorAction SilentlyContinue
New-Item  $ROOT/temp/$name -ItemType Directory
New-Item  $ROOT/temp/$name/$name -ItemType Directory
gh release download -R Chuyu-Team/Dism-Multi-language -p "Dism*.zip" `
    -O  "$ROOT/temp/$name/$name.zip" --clobber
7z x "$ROOT/temp/$name/$name.zip"  "-o$ROOT/temp/$name/$name"

build-pkg
