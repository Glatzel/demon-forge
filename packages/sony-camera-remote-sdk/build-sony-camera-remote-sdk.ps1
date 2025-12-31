Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
python download.py

$zipfile = (Get-ChildItem "$ROOT/temp/$name/*.zip")[0]
$zipfile.BaseName -match "CrSDK_v(\d+)\.(\d+)\.(\d+).+_(\S+)"
$platform = $Matches[4]
foreach ($f in Get-ChildItem "$ROOT/temp/$name/*.zip") {
    $f.BaseName -match "CrSDK_v(\d+)\.(\d+)\.(\d+).+_(\S+)"
    $platform = $Matches[4]
    7z x "$f" "-o$ROOT/temp/$name/unzip/$platform"
}
New-Item $env:PREFIX/$name -ItemType Directory
Copy-Item "$ROOT/temp/$name/unzip/$platform/*" "$env:PREFIX/$name" -Recurse

Remove-Item $env:PREFIX/app/*.h
Remove-Item $env:PREFIX/app/*.cpp
Remove-Item $env:PREFIX/*.zip
Remove-Item $env:PREFIX/external/opencv/ -Recurse
