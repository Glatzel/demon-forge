$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
./configure "--prefix=$env:PREFIX"
make -j$(nproc)
make install