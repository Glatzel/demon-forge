$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
sudo apt-get update
sudo apt-get install -y make gcc bc bison flex elfutils python3-pyelftools curl patch libelf-dev
make -j$(env:nproc)
make install PREFIX=$PREFIX
