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
Copy-Item ./stub.pyi ./rawpy/rawpy/__init__.pyi
$env:CMAKE_PREFIX_PATH = Resolve-Path "./.pixi/envs/vfx2024/Library"
Set-Location rawpy
../scripts/init-vs.ps1
pixi run -e vfx2024 python -u setup.py bdist_wheel
