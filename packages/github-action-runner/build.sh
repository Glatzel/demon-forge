if [[ "${TARGET_PLATFORM}" == "osx-arm64" ]]; then
    gh release download -R actions/runner \
        -p "*osx-arm64*" \
        -O "${PKG_NAME}.tar.gz"
elif [[ "${TARGET_PLATFORM}" == "linux-64" ]]; then
    gh release download -R actions/runner \
        -p "*linux-x64*" \
        -O "${PKG_NAME}.tar.gz"
elif [[ "${TARGET_PLATFORM}" == "linux-aarch64" ]]; then
    gh release download -R actions/runner \
        -p "*linux-arm64*" \
        -O "${PKG_NAME}.tar.gz"
fi

tar -xzf "${PKG_NAME}.tar.gz" -C "${PREFIX}"
