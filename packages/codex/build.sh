case "$target_platform" in
    linux-64)
        target="x86_64-unknown-linux-gnu"
        ;;
    linux-aarch64)
        target="aarch64-unknown-linux-gnu"
        ;;
    osx-arm64)
        target="aarch64-apple-darwin"
        ;;
    *)
        echo "Unsupported platform: $target_platform"
        exit 1
        ;;
esac
export CARGO_BUILD_JOBS=1
export CODEX_REPO_ROOT=$(pwd)
python scripts/build_codex_package.py \
    --target "$target" \
    --variant codex \
    --cargo-profile release \
    --package-dir "$PREFIX" \
    --force \
    --strip all \
    --strip-tool strip
cp -r "$RECIPE_DIR/unix/etc" "$PREFIX/"
