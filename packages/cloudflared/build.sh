if [ "${TARGET_PLATFORM}" = "linux-64" ]; then
    gh release download -R "cloudflare/${PKG_NAME}" \
        -p "${PKG_NAME}-linux-amd64" \
        -O "${PREFIX}/bin/${PKG_NAME}"
fi

if [ "${TARGET_PLATFORM}" = "linux-aarch64" ]; then
    gh release download -R "cloudflare/${PKG_NAME}" \
        -p "${PKG_NAME}-linux-arm64" \
        -O "${PREFIX}/bin/${PKG_NAME}"
fi

chmod +rwx "${PREFIX}/bin/${PKG_NAME}"
