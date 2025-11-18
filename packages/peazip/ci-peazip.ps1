Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

$latest_version = get-version-github -repo "https://github.com/$name/PeaZip"
update-recipe -version $latest_version

gh release download -R https://github.com/$name/PeaZip -p "peazip_portable-*.WIN64.zip" `
    -O  $ROOT/temp/$name/$name.zip --clobber
7z x "$ROOT/temp/$name/$name.zip" "-o$ROOT/temp/$name"

build-pkg
