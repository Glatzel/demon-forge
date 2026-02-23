New-Item $env:PREFIX/bin/${env:PKG_NAME} -ItemType Directory
if ($IsWindows) {
    gh release download -R 2dust/v2rayN -p "v2rayN-windows-64-desktop.zip" `
        -O  ./${env:PKG_NAME}.zip
}
7z x "${env:PKG_NAME}.zip" "-o./${env:PKG_NAME}" 
 if ($IsWindows) { 
     Copy-Item "./${env:PKG_NAME}/v2rayN-windows-64/*" "$env:PREFIX/bin/${env:PKG_NAME}/" -Recurse 
 }
# shortcut
New-Item $env:PREFIX/Menu -ItemType Directory
Copy-Item "${env:RECIPE_DIR}/${env:PKG_NAME}.json" "$env:PREFIX/Menu"
