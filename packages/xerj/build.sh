ROOT=$(git rev-parse --show-toplevel)
. "$ROOT/scripts/util.sh"
if [[ "${target_platform}" == "linux-aarch64" ]]; then
  export RUSTFLAGS="${RUSTFLAGS} -C target-feature=+fp16"
fi
cargo_build --git https://github.com/xerj-org/xerj --tag "v$PKG_VERSION-rc.100" xerj-server
