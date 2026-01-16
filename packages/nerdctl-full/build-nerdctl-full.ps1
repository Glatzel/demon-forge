if ($IsLinux -and $arch -eq "X64") {
    gh release download -R "containerd/nerdctl" -p "${env:PKG_NAME}-*.*.*-linux-amd64.tar.gz" `
        -O  ./${env:PKG_NAME}.tar.gz --clobber
}
if ($IsLinux -and $arch -eq "Arm64") {
    gh release download -R "containerd/nerdctl" -p "${env:PKG_NAME}-*.*.*-linux-arm64.tar.gz" `
        -O  ./${env:PKG_NAME}.tar.gz --clobber
}
7z x ./${env:PKG_NAME}.tar.gz "-o./"
7z x ./*.tar "-o./${env:PKG_NAME}"Copy-Item "./${env:PKG_NAME}/*" "$env:PREFIX/" -Recurse
# do not use bundled runc
Remove-Item "$env:PREFIX/bin/runc"
