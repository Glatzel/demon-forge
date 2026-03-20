$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
if($IsMacOS)
{
    brew tap slp/krun
    brew install krunvm
    sh ./build_on_krunvm.sh
}
$arch=uname -m
make ARCH=$arch
make PREFIX=$env:PREFIX install
