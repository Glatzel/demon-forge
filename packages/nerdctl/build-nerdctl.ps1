if ($IsWindows) {
    gh release download -R "containerd/nerdctl" -p "nerdctl-*-windows-amd64.tar.gz" `
        -O  ./${env:PKG_NAME}.tar.gz --clobber
}
if ($IsLinux -and $arch -eq "X64") {
    gh release download -R "containerd/nerdctl" -p "nerdctl-?.*.*-linux-amd64.tar.gz" `
        -O  ./${env:PKG_NAME}.tar.gz --clobber
}
if ($IsLinux -and $arch -eq "Arm64") {
    gh release download -R "containerd/nerdctl" -p "nerdctl-?.*.*-linux-arm64.tar.gz" `
        -O  ./${env:PKG_NAME}.tar.gz --clobber
}
7z x "${env:PKG_NAME}.tar.gz"
7z x "${env:PKG_NAME}.tar" "-o./${env:PKG_NAME}"
New-Item $env:PREFIX/bin -ItemType Directory
Copy-Item "./${env:PKG_NAME}/*" "$env:PREFIX/bin/" -Recurse
