$ROOT = git rev-parse --show-toplevel
gh release download -R "ryanoasis/nerd-fonts" -p "CascadiaMono.zip" `
        -O  $ROOT/temp/font.zip --clobber
7z x "$ROOT/temp/font.zip" "-o$ROOT/temp/font"
pixi install
foreach ($f in "CaskaydiaMonoNerdFont-Regular", "CaskaydiaMonoNerdFont-Italic", "CaskaydiaMonoNerdFont-Bold", "CaskaydiaMonoNerdFont-BoldItalic") {
        pixi run pyftsubset $ROOT/temp/font/$f.ttf `
                --output-file=$ROOT/html/src/style/webfont/$f.woff2 `
                --flavor=woff2 `
                --layout-features='*' `
                --glyphs='*'
}
