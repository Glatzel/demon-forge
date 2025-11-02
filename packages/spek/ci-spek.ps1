Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1


$latest_version = get-latest-version -repo "https://github.com/alexkay/$name"
$latest_version = "$latest_version".Replace("v", "")

Remove-Item $ROOT/temp/$name -Recurse -ErrorAction SilentlyContinue
New-Item  $ROOT/temp/$name -ItemType Directory
gh release download -R alexkay/$name -p "$name-*.zip" `
    -O  $ROOT/temp/$name/$name.zip --clobber
7z x "$ROOT/temp/$name/$name.zip" "-o$ROOT/temp/$name/$name"
update-recipe -version $latest_version
build-pkg
