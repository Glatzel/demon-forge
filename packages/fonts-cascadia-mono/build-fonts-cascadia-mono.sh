gh release download -R "ryanoasis/nerd-fonts" -p "CascadiaMono.zip" -O ./fonts.zip --clobber

7z x "./fonts.zip" "-o${PREFIX}/fonts"

for f in "${PREFIX}/fonts/"*.ttf; do
    pyftsubset "$f" \
        --output-file="${PREFIX}/fonts/$(basename "${f%.ttf}").woff2" \
        --flavor=woff2 \
        --layout-features='*' \
        --glyphs='*'
done
