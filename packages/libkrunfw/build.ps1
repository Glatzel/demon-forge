$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
make
make install PREFIX=$PREFIX
