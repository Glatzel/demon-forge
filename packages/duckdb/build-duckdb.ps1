$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
python scripts/windows_ci.py
cmake-build `
    -DFORCE_COLORED_OUTPUT=1 `
    -DOVERRIDE_GIT_DESCRIBE="" `
    -DCMAKE_C_COMPILER=clang-cl `
    -DCMAKE_CXX_COMPILER=clang-cl
