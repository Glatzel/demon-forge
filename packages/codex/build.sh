case "$target_platform" in
    linux-64)
        asset="x86_64-unknown-linux-gnu"
        ;;
    linux-aarch64)
        asset="aarch64-unknown-linux-gnu"
        ;;
    osx-arm64)
        asset="codex-aarch64-apple-darwin.tar.gz"
        ;;
    *)
        echo "Unsupported platform: $target_platform"
        exit 1
        ;;
esac
cp -r ./* "${PREFIX}/"
cp -r "$RECIPE_DIR/unix/etc" "$PREFIX/"
ln -sf ../bin/rg "$PREFIX/codex-path/rg"
# Pixi: prevent CONDA_PREFIX from leaking into sandboxed processes
mkdir -p "${PREFIX}/etc/pixi/codex"
touch "${PREFIX}/etc/pixi/codex/global-ignore-conda-prefix"
