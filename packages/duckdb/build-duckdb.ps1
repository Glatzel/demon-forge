$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
cmake-build `
    -DFORCE_COLORED_OUTPUT=1 `
    -DOVERRIDE_GIT_DESCRIBE=""
