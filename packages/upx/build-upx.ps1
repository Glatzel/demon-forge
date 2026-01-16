if ($IsWindows) {
    gh release download -R ${env:PKG_NAME}/${env:PKG_NAME} -p "*-win64.zip" `
        -O  ./${env:PKG_NAME}.zip --clobber
    7z x "./${env:PKG_NAME}.zip" "-o./${env:PKG_NAME}"
}
# if ($IsLinux) {
#     gh release download -R obsproject/${env:PKG_NAME} -p "*-amd64-linux.tar.xz" `
#         -O  ./${env:PKG_NAME}.tar.xz --clobber
#     7z x "./${env:PKG_NAME}.tar.xz" "-o./${env:PKG_NAME}"
# }
New-Item $env:PREFIX/bin/${env:PKG_NAME} -ItemType Directory
Copy-Item "./${env:PKG_NAME}/${env:PKG_NAME}*/*" "$env:PREFIX/bin/${env:PKG_NAME}" -Recurse
