ROOT=$(git rev-parse --show-toplevel)
. "$ROOT/scripts/util.sh"
case "$target_platform" in
    linux-64)
        export CARGO_BUILD_JOBS=1
        ;;
    linux-aarch64)
        export CARGO_BUILD_JOBS=1
        ;;
    osx-arm64)
         echo "osx"
        ;;
    *)
        echo "Unsupported platform: $target_platform"
        exit 1
        ;;
esac
cargo_build  --git https://github.com/tangency-labs/solidcraft --tag "v$PKG_VERSION" solidcraft-cli
cargo_build  --git https://github.com/tangency-labs/solidcraft --tag "v$PKG_VERSION" solidcraft
mkdir $PREFIX/Menu
cp "${RECIPE_DIR}/${PKG_NAME}.json" "$PREFIX/Menu"
