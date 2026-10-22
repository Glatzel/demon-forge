ROOT=$(git rev-parse --show-toplevel)
. "$ROOT/scripts/util.sh"
if [ "$(uname)" = "Linux" ]; then
    export LIBCLANG_PATH="$BUILD_PREFIX/lib"
    sed -i '/target\.x86_64-unknown-linux-gnu/{n;/rustflags/d;}' .cargo/config.toml
    sed -i '/target\.aarch64-unknown-linux-gnu/{n;/rustflags/d;}' .cargo/config.toml
fi
set -- $(get_cargo_arg)
cargo install --path ./easytier "$@"
