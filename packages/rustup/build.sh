ROOT=$(git rev-parse --show-toplevel)
. "$ROOT/scripts/util.sh"
cargo_build --features vendored-openssl --git https://github.com/rust-lang/rustup --tag "$PKG_VERSION" rustup
cp -r "$RECIPE_DIR/unix/etc" "$PREFIX/"
mkdir -p "$PREFIX/.cargo/bin"
mv "$PREFIX/bin/rustup-init" "$PREFIX/.cargo/bin/rustup"
for i in \
    cargo \
    cargo-clippy \
    cargo-fmt \
    cargo-miri \
    clippy-driver \
    rls \
    rust-analyzer \
    rust-gdb \
    rust-gdbgui \
    rust-lldb \
    rustc \
    rustdoc \
    rustfmt \
    rustup
do
    ln -s "../.cargo/bin/rustup" "$PREFIX/bin/$i"
done
