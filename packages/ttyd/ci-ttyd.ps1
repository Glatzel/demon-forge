Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

$latest_version = get-latest-version -repo "tsl0922/$name"
$latest_version = "$latest_version".Replace("$name-", "")

Remove-Item $ROOT/temp/$name -Recurse -ErrorAction SilentlyContinue
New-Item  $ROOT/temp/$name -ItemType Directory
gh release download -R "tsl0922/$name" -p "*.exe" `
    -O  $ROOT/temp/$name/$name.exe --clobber
update-recipe -version $latest_version
build-pkg
