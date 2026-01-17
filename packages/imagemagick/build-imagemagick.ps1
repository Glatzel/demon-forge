gh release download `
    -R "ImageMagick/ImageMagick" `
    -p "ImageMagick-*-portable-Q16-HDRI-x64.7z" `
    -O  ./${env:PKG_NAME}.7z `
   
7z x "${env:PKG_NAME}.7z" "-o./${env:PKG_NAME}"
New-Item $env:PREFIX/bin/${env:PKG_NAME} -ItemType Directory
Copy-Item "./${env:PKG_NAME}/*" "$env:PREFIX/bin/${env:PKG_NAME}" -Recurse
