$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
cargo_build dua-cli
