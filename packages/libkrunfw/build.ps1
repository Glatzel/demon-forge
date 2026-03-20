$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
if($IsMacOS)
{
    brew tap slp/krun
    brew install krunvm
    sh ./build_on_krunvm.sh
}
make V=1
make PREFIX=$env:PREFIX install
