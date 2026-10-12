ROOT=$(git rev-parse --show-toplevel)
. "$ROOT/scripts/util.sh"
set -- $(get_cargo_arg)
cargo install --path . --features vendored-openssl "$@"
cp -r "$RECIPE_DIR/unix/etc" "$PREFIX/"
export RUSTUP_HOME="${PREFIX}/.rustup"
export CARGO_HOME="${PREFIX}"
$PREFIX/bin/rustup-init -y --default-toolchain stable --profile complete
rm -rf $PREFIX/.rustup
rm $PREFIX/bin/rustup-init*