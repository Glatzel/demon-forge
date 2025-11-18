Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
create-temp -name $name
$latest_version = get-version-url -url "https://www.cpuid.com/softwares/cpu-z.html" -pattern 'cpu-z_(\d+\.\d+)-en.zip'
update-recipe -version $latest_version

pixi run -e selenium python download.py

$zipfile = (Get-ChildItem "$ROOT/temp/$name/*.zip")[0]
7z x "$zipfile" "-o$ROOT/temp/$name/$name"
build-pkg
