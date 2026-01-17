$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
python $env:RECIPE_DIR/download.py
$zipfile = (Get-ChildItem "./*.zip")[0]
$zipfile.BaseName -match "CrSDK_v(\d+)\.(\d+)\.(\d+).+_(\S+)"
$platform = $Matches[4]
foreach ($f in Get-ChildItem "./*.zip") {
    $f.BaseName -match "CrSDK_v(\d+)\.(\d+)\.(\d+).+_(\S+)"
    $platform = $Matches[4]
    7z x "$f" "-ounzip/$platform"
}
New-Item "$env:PREFIX/${env:PKG_NAME}" -ItemType Directory
Copy-Item "./${env:PKG_NAME}/unzip/$platform/*" "$env:PREFIX/${env:PKG_NAME}" -RecurseRemove-Item $env:PREFIX/${env:PKG_NAME}/app/*.h
Remove-Item $env:PREFIX/${env:PKG_NAME}/app/*.cpp
Remove-Item $env:PREFIX/${env:PKG_NAME}/*.zip
Remove-Item $env:PREFIX/${env:PKG_NAME}/external/opencv/ -Recurse
