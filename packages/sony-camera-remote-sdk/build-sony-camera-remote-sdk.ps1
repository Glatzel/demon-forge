Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

New-Item $env:PREFIX/$name -ItemType Directory
if ($IsLinux -and $is_arm) {
    Copy-Item "$ROOT/temp/$name/unzip/*Linux64ARMv8" "$env:PREFIX/$name" -Recurse
}
elseif ($IsLinux -and (-not $is_arm)) {
    Copy-Item "$ROOT/temp/$name/unzip/*Linux64PC" "$env:PREFIX/$name" -Recurse
}
else {
    Copy-Item "$ROOT/temp/$name/unzip/*" "$env:PREFIX/$name" -Recurse
}
 foreach ($arch in Get-ChildItem $env:PREFIX/$name) {
    Remove-Item $arch/app/*.h
    Remove-Item $arch/app/*.cpp
    Remove-Item $arch/*.zip
    Remove-Item $arch/external/opencv/ -Recurse
}
