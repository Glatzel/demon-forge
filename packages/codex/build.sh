case "$target_platform" in
    linux-64)
        target="x86_64-unknown-linux-gnu"
        ;;
    linux-aarch64)
        target="aarch64-unknown-linux-gnu"
        ;;
    osx-arm64)
        target="aarch64-apple-darwin"
        export CARGO_NET_GIT_FETCH_WITH_CLI=true
        ;;
    *)
        echo "Unsupported platform: $target_platform"
        exit 1
        ;;
esac
export CARGO_BUILD_JOBS=1
export CARGO_PROFILE_RELEASE_STRIP=symbols
export CODEX_REPO_ROOT=$(pwd)
just assemble-codex-package --cargo-profile release --package-dir out --target "${CARGO_BUILD_TARGET}" --rg-bin "${PREFIX}/bin/rg"
cp -r "$RECIPE_DIR/unix/etc" "$PREFIX/"
ln -s ../bin/rg "$PREFIX/codex-path/rg"
