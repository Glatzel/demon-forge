Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1


$latest_version = get-latest-version -repo "LibrePCB/LibrePCB"
update-recipe -version $latest_version

Remove-Item $ROOT/temp/$name -Recurse -ErrorAction SilentlyContinue
New-Item $ROOT/temp/$name -ItemType Directory
aria2c -c -x16 -s16 -d "$ROOT/temp/$name/" `
    "https://download.librepcb.org/releases/$latest_version/librepcb-$latest_version-windows-x86_64.zip" `
    -o "$name.zip"

7z x "$ROOT/temp/$name/$name.zip" "-o$ROOT/temp/$name/$name"

build-pkg
