$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
if($env:TARGET_PLATFORM -eq 'linux-64')
{
    gh release download -R zerocore-ai/microsandbox `
        -p "libkrunfw-linux-x86_64.tar.gz" `
        -O libkrunfw.tar.gz
}
if($env:TARGET_PLATFORM -eq 'linux-aarch64')
{
    gh release download -R zerocore-ai/microsandbox `
        -p "libkrunfw-linux-aarch.tar.gz" `
        -O libkrunfw.tar.gz
}
if($env:TARGET_PLATFORM -eq 'osx-arm64')
{
    gh release download -R zerocore-ai/microsandbox `
        -p "microsandbox-darwin-aarch64.tar.gz" `
        -O libkrunfw.tar.gz
}
7z x libkrunfw.tar.gz -so | 7z x -si -ttar "-o$env:PREFIX/bin"
