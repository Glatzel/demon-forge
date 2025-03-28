Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
$name = get-name

$latest_version = get-latest-version -repo "https://github.com/kovidgoyal/$name"
$latest_version = "$latest_version".Replace("v", "")

Remove-Item $ROOT/temp/$name -Recurse -ErrorAction SilentlyContinue
New-Item  $ROOT/temp/$name -ItemType Directory
gh release download -R https://github.com/kovidgoyal/$name -p "$name-portable*" `
    -O  $ROOT/temp/$name/$name.exe --clobber

Remove-Item C:/temp -Recurse -ErrorAction SilentlyContinue
New-Item  C:/temp -ItemType Directory
Start-Process -FilePath "$ROOT/temp/$name/$name.exe" -ArgumentList "C:/temp" -Wait

update-recipe -version $latest_version
build-pkg
Remove-Item C:/temp -Recurse -ErrorAction SilentlyContinue
