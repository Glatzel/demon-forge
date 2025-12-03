Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

New-Item $env:PREFIX/bin/$name -ItemType Directory
Copy-Item "$ROOT/temp/$name/$name/*" "$env:PREFIX/bin/$name" -Recurse
if($IsWindows){
    Copy-Item $PSScriptRoot/update-geofile.ps1 $env:PREFIX/bin/$name/
}
else{
    Copy-Item $PSScriptRoot/update-geofile.sh $env:PREFIX/bin/$name/
}
