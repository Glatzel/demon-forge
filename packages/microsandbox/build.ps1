$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
if($env:TARGET_PLATFORM -eq 'linux-64')
{
    gh release download -R zerocore-ai/microsandbox `
        -p "microsandbox-linux-x86_64.tar.gz" `
        -O microsandbox.tar.gz
}
if($env:TARGET_PLATFORM -eq 'linux-aarch64')
{
    gh release download -R zerocore-ai/microsandbox `
        -p "microsandbox-linux-aarch64.tar.gz" `
        -O microsandbox.tar.gz
}
if($env:TARGET_PLATFORM -eq 'osx-arm64')
{
    gh release download -R zerocore-ai/microsandbox `
        -p "microsandbox-darwin-aarch64.tar.gz" `
        -O microsandbox.tar.gz
}
7z x microsandbox.tar.gz -so | 7z x -si -ttar "-o$env:PREFIX/bin"
chmod +x $PREFIX/bin/msb
chmod +x $PREFIX/bin/msbnet
