gh release download `
    -R "ImageMagick/ImageMagick" `
    -p "ImageMagick-*-portable-Q16-HDRI-x64.7z" `
    -O  ./${env:PKG_NAME}.7z `

7z x "${env:PKG_NAME}.7z" "-o$env:PREFIX/bin"
