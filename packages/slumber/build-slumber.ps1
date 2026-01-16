$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

build-cargo-package $name $name
