Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
$name = get-name

Remove-Item $ROOT/temp/$name -Recurse -ErrorAction SilentlyContinue
New-Item $ROOT/temp/$name -ItemType Directory
Set-Location $ROOT/temp/$name
pixi run -e pip pip download rawpy

$whlfile=(Get-ChildItem "$ROOT/temp/$name/$name*.whl")[0]
$whlfile.BaseName -match "rawpy-(\S+)-\S+-\S+-win_amd64"
$latest_version=$Matches[1]

#rattler build
Set-Location $PSScriptRoot
update-recipe -version $latest_version
build-pkg
