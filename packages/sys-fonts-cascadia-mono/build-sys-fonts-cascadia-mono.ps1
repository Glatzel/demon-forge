gh release download -R "ryanoasis/nerd-fonts" -p "CascadiaMono.zip" -O ./fonts.zip --clobber
7z x "./fonts.zip" "-o$env:PREFIX/fonts"
foreach( $f in Get-ChildItem "$env:PREFIX/fonts/*.ttf")
{
    pyftsubset $f `
        --output-file="$env:PREFIX/fonts/$($f.BaseName).woff2" `
        --flavor=woff2 `
        --layout-features='*' `
        --glyphs='*'
}
