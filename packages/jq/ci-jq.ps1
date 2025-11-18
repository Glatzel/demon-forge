Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

$latest_version = get-version-github -repo "jqlang/$name"
$latest_version = "$latest_version".Replace("$name-", "")
update-recipe -version $latest_version

gh release download -R "jqlang/$name" -p "$name-windows-amd64.exe" `
    -O  $ROOT/temp/$name/$name.exe --clobber

build-pkg
