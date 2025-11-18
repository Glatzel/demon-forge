Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1


$latest_version = get-version-github -repo "pbatard/$name"
update-recipe -version $latest_version

gh release download -R "pbatard/$name" -p "$name-*.??.exe" `
    -O  $ROOT/temp/$name/$name.exe --clobber

build-pkg
