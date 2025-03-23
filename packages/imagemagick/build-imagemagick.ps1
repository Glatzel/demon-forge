Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
$name=get-name
New-Item $env:PREFIX/bin/$name -ItemType Directory
foreach ($f in Get-ChildItem  "$env:RECIPE_DIR/../../temp/$name/ImageMagick-*-portable-Q16-HDRI-x64/*") {
    Copy-Item $f "$env:PREFIX/bin/$name"
}
