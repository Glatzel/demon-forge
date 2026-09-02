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
python scripts/build_codex_package.py \
    --target "$target" \
    --variant open-interpreter \
    --cargo-profile release \
    --package-dir "$PREFIX" \
    --force
strip "$PREFIX/bin/interpreter"
strip "$PREFIX/bin/i"
strip "$PREFIX/bin/codex-code-mode-host"