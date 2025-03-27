Set-Location $PSScriptRoot
Set-Location ..

# clone rawpy
git clone https://github.com/letmaik/rawpy.git --depth 1

# build
$env:CMAKE_PREFIX_PATH= Resolve-Path "./.pixi/envs/vfx2024/Library"
Set-Location rawpy
../scripts/init-vs.ps1
git apply ../numpy_require.patch
pixi run -e vfx2024 python -u setup.py bdist_wheel
