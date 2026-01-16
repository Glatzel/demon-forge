aria2c -c -x16 -s16 -d ./ `
    https://www.intrsio.com/downloadFile.jsp?fileName=PandaCAD-x64-v${env:PKG_VERSION}-Setup.exe `
    -o "${env:PKG_NAME}.exe"
7z x "./${env:PKG_NAME}.exe" "-o$env:PREFIX/bin/${env:PKG_NAME}"
# shortcut
New-Item $env:PREFIX/Menu -ItemType Directory
Copy-Item "${env:RECIPE_DIR}/${env:PKG_NAME}.json" "$env:PREFIX/Menu"
