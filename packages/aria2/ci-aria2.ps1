Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

$latest_version = get-version-github -repo "$name/$name"
$latest_version = "$latest_version".Replace("release-", "")
update-recipe -version $latest_version

Remove-Item $ROOT/temp/$name -Recurse -ErrorAction SilentlyContinue
New-Item  $ROOT/temp/$name -ItemType Directory
gh release download -R $name/$name -p "$name-*-win-64bit*.zip" `
    -O  $ROOT/temp/$name/$name.zip --clobber
7z x "$ROOT/temp/$name/$name.zip" "-o$ROOT/temp/$name"
build-pkg
