Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
create-temp -name $name

$latest_version = get-version-github -repo "https://github.com/obsproject/$name"
update-recipe -version $latest_version

gh release download -R obsproject/$name -p "*-Windows-x64.zip" `
    -O  $ROOT/temp/$name/$name.zip --clobber
7z x "$ROOT/temp/$name/$name.zip" "-o$ROOT/temp/$name/$name"

build-pkg
