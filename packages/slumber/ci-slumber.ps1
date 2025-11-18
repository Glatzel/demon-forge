Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
create-temp -name $name
$latest_version = get-version-crateio -name $name
update-recipe -version $latest_version

if ($IsWindows) {
    gh release download -R LucasPickering/$name -p "*windows*.zip" `
        -O  $ROOT/temp/$name/$name.zip --clobber
    7z x "$ROOT/temp/$name/$name.zip" "-o$ROOT/temp/$name/$name"
}
if ($IsLinux) {
    gh release download -R LucasPickering/$name -p "slumber-x86_64-unknown-linux-gnu.tar.xz" `
        -O  $ROOT/temp/$name/$name.tar.xz --clobber
    New-Item $ROOT/temp/$name/temp -ItemType Directory
    New-Item $ROOT/temp/$name/$name -ItemType Directory
    tar -xf "$ROOT/temp/$name/$name.tar.xz" -C "$ROOT/temp/$name/temp"
    Copy-Item  "$ROOT/temp/$name/temp/slumber-x86_64-unknown-linux-gnu/*" "$ROOT/temp/$name/$name" -Recurse
}

build-pkg
