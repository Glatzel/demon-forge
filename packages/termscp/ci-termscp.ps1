Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
$latest_version = get-version-crateio -name $name
update-recipe -version $latest_version

gh release download -R veeso/$name -p "*x86_64-pc-windows*.zip" `
    -O  $ROOT/temp/$name/$name.zip --clobber
    7z x "$ROOT/temp/$name/$name.zip" "-o$ROOT/temp/$name"

build-pkg
