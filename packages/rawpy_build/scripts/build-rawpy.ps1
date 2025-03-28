Set-Location $PSScriptRoot/..
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

pixi install --all

# clone rawpy
Remove-Item ./rawpy -Recurse -Force -ErrorAction SilentlyContinue
git clone https://github.com/letmaik/rawpy.git

# checkout latest tag
Set-Location rawpy
$rawpy_version = get-latest-version -repo "letmaik/rawpy"
git checkout tags/"$rawpy_version" -b "$rawpy_version-branch"
Set-Location $PSScriptRoot/..

# apply patch
git apply numpy_require.patch

# build
$env:CMAKE_PREFIX_PATH = Resolve-Path "./.pixi/envs/default/Library"
Set-Location rawpy
../scripts/init-vs.ps1
pixi run python -u setup.py bdist_wheel

# unarchive
Set-Location $PSScriptRoot/..
$whlfile=(Get-ChildItem "rawpy/dist/*.whl")[0]
7z -x "$whlfile" "-orawpy/dist"

#copy file
Set-Location $PSScriptRoot/..
Remove-Item mod -Recurse -Force -ErrorAction SilentlyContinue
New-Item mod/rawpy -ItemType Directory -ErrorAction SilentlyContinue

Copy-Item ./rawpy/dist/rawpy/* ./mod/rawpy

$rawpy_version="$rawpy_version".Replace("v","")
(Get-Content -Path "./helper/pyproject.toml") -replace '^version = ''.*''', "version = '$rawpy_version'" | Set-Content -Path "./helper/pyproject.toml"
Copy-Item ./helper/pyproject.toml ./mod