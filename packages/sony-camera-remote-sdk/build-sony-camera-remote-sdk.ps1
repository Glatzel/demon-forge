$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

python download.py

$zipfile = (Get-ChildItem "./*.zip")[0]
$zipfile.BaseName -match "CrSDK_v(\d+)\.(\d+)\.(\d+).+_(\S+)"
$platform = $Matches[4]
foreach ($f in Get-ChildItem "./*.zip") {
    $f.BaseName -match "CrSDK_v(\d+)\.(\d+)\.(\d+).+_(\S+)"
    $platform = $Matches[4]
    7z x "$f" "-o./unzip/$platform"
}
New-Item $env:PREFIX/$name -ItemType Directory
Copy-Item "./$name/unzip/$platform/*" "$env:PREFIX/$name" -Recurse

Remove-Item $env:PREFIX/$name/app/*.h
Remove-Item $env:PREFIX/$name/app/*.cpp
Remove-Item $env:PREFIX/$name/*.zip
Remove-Item $env:PREFIX/$name/external/opencv/ -Recurse
