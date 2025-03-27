Set-Location $PSScriptRoot/..

pixi install --all

# clone rawpy
Remove-Item ./rawpy -Recurse -Force -ErrorAction SilentlyContinue
git clone https://github.com/letmaik/rawpy.git --depth 1
git apply numpy_require.patch

# build
$env:CMAKE_PREFIX_PATH = Resolve-Path "./.pixi/envs/vfx2024/Library"
Set-Location rawpy
../scripts/init-vs.ps1
pixi run -e vfx2024 python -u setup.py bdist_wheel
Rename-Item ./dist/rawpy-*.*.*-cp311-cp311-win_amd64.whl "rawpy-2024-cp311-cp311-win_amd64.whl"
