$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

if ($IsLinux -and $arch -eq "X64") {
    gh release download -R "containerd/nerdctl" -p "$name-*.*.*-linux-amd64.tar.gz" `
        -O  ./$name.tar.gz --clobber
}
if ($IsLinux -and $arch -eq "Arm64") {
    gh release download -R "containerd/nerdctl" -p "$name-*.*.*-linux-arm64.tar.gz" `
        -O  ./$name.tar.gz --clobber
}
7z x ./$name.tar.gz "-o./"
7z x ./*.tar "-o./$name"

Copy-Item "./$name/$name/*" "$env:PREFIX/" -Recurse
# do not use bundled runc
Remove-Item "$env:PREFIX/bin/runc"
