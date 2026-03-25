$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
dnf install -y 'dnf-command(builddep)' python3-pyelftools curl
dnf builddep -y kernel
make -j$(nproc)
make install PREFIX=$PREFIX
