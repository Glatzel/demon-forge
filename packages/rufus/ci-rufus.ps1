Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1


$latest_version = get-latest-version -repo "pbatard/$name"
$latest_version = "$latest_version".Replace("v", "")
update-recipe -version $latest_version

Remove-Item $ROOT/temp/$name -Recurse -ErrorAction SilentlyContinue
New-Item  $ROOT/temp/$name -ItemType Directory
gh release download -R "pbatard/$name" -p "$name-*.??.exe" `
    -O  $ROOT/temp/$name/$name.exe --clobber

build-pkg
