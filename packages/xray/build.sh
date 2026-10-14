ROOT=$(git rev-parse --show-toplevel)
. "$ROOT/scripts/util.sh"

case "${TARGET_PLATFORM:-}" in
    linux-64)
        ASSET="Xray-linux-64.zip"
        ;;
    linux-aarch64)
        ASSET="Xray-linux-arm64-v8a.zip"
        ;;
    macos-arm64)
        ASSET="Xray-macos-arm64-v8a.zip"
        ;;
    *)
        echo "Unsupported platform: ${TARGET_PLATFORM:-unknown}"
        exit 1
        ;;
esac

gh release download \
    -R "XTLS/Xray-core" \
    -p "$ASSET" \
    -O "./${PKG_NAME}.zip"

mkdir -p "$PREFIX/bin/${PKG_NAME}"

7z x "./${PKG_NAME}.zip" "-o$PREFIX/bin/${PKG_NAME}"

if [ "${TARGET_PLATFORM}" = "windows-64" ]; then
    :
else
    cp "$RECIPE_DIR/update-geofile.sh" \
       "$PREFIX/bin/${PKG_NAME}/"
fi

if [ -f "$PREFIX/bin/${PKG_NAME}/${PKG_NAME}" ]; then
    chmod +rwx "$PREFIX/bin/${PKG_NAME}/${PKG_NAME}"
fi
