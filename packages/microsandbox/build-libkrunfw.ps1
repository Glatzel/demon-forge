gh release libkrunfw-windows-x86_64.dll
gh release download -R "superradcompany/microsandbox" -p "libkrunfw-windows-x86_64.dll" `
    -O  $env:PREFIX/bin/libkrunfw.dll
