gh release download -R "ryanoasis/nerd-fonts" -p "CascadiaMono.zip" `
        -O  ./temp/font.zip --clobber
7z x "./temp/font.zip" "-o./temp/font" -bb3
new-item ./html/src/style/webfont -itemtype directory
foreach ($f in "CaskaydiaMonoNerdFont-Regular", "CaskaydiaMonoNerdFont-Italic", "CaskaydiaMonoNerdFont-Bold", "CaskaydiaMonoNerdFont-BoldItalic") {
        pyftsubset ./temp/font/$f.ttf `
                --output-file=./html/src/style/webfont/$f.woff2 `
                --flavor=woff2 `
                --layout-features='*' `
                --glyphs='*'
}
