$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
$arch = uname -m
make ARCH=$arch CC="$env:CC"
make install PREFIX=$PREFIX
