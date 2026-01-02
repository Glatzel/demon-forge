Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
if ($IsWindows) {
    gh release download -R "containerd/nerdctl" -p "nerdctl-*-windows-amd64.tar.gz" `
        -O  $ROOT/temp/$name/$name.tar.gz --clobber
}
if ($IsLinux -and $arch -eq "X64") {
    gh release download -R "containerd/nerdctl" -p "nerdctl-?.*.*-linux-amd64.tar.gz" `
        -O  $ROOT/temp/$name/$name.tar.gz --clobber
}
if ($IsLinux -and $arch -eq "Arm64") {
    gh release download -R "containerd/nerdctl" -p "nerdctl-?.*.*-linux-arm64.tar.gz" `
        -O  $ROOT/temp/$name/$name.tar.gz --clobber
}
7z x $ROOT/temp/$name/$name.tar.gz "-o$ROOT/temp/$name/"
7z x $ROOT/temp/$name/$name.tar "-o$ROOT/temp/$name/$name"
New-Item $env:PREFIX/bin -ItemType Directory
Copy-Item "$ROOT/temp/$name/$name/*" "$env:PREFIX/bin/" -Recurse
