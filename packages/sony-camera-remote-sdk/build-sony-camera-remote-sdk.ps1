Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

New-Item $env:PREFIX/$name -ItemType Directory
Copy-Item "$ROOT/temp/$name/unzip/*" "$env:PREFIX/$name" -Recurse

foreach ($arch in Get-ChildItem $env:PREFIX/$name) {
    Remove-Item $arch/app/*.h
    Remove-Item $arch/app/*.cpp
    Remove-Item $arch/*.zip
    Remove-Item $arch/external/opencv/ -Recurse
}
