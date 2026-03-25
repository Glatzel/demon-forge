if ($env:TARGET_PLATFORM -eq "linux-64") {
    $pattern = "x86_64"
}if ($env:TARGET_PLATFORM -eq "linux-aarch64") {
    $pattern = "aarch64"
}
gh release download -R "containers/${env:PKG_NAME}" -p "${env:PKG_NAME}-$pattern.tgz" `
    -O  ${env:PKG_NAME}.tgz
7z x "${env:PKG_NAME}.tgz" "-o${env:PREFIX}/lib"
