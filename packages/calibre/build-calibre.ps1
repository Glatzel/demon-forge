gh release download -R https://github.com/kovidgoyal/${env:PKG_NAME} -p "${env:PKG_NAME}-portable*" `
    -O  ./${env:PKG_NAME}.exe
Remove-Item C:/temp -Recurse -ErrorAction SilentlyContinue
New-Item  C:/temp -ItemType Directory
Start-Process -FilePath "./${env:PKG_NAME}.exe" -ArgumentList "C:/temp" -Wait
New-Item $env:PREFIX/bin/${env:PKG_NAME} -ItemType Directory
Copy-Item "C:/temp/Calibre Portable/*" "$env:PREFIX/bin/${env:PKG_NAME}" -Recurse
# shortcut
New-Item $env:PREFIX/Menu -ItemType Directory
Copy-Item "${env:RECIPE_DIR}/${env:PKG_NAME}.json" "$env:PREFIX/Menu"
