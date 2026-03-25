$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
$arch = uname -m
make ARCH=$arch
make install PREFIX=$PREFIX
