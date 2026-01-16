$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

aria2c -c -x16 -s16 -d ./ `
    https://www.intrsio.com/downloadFile.jsp?fileName=PandaCAD-x64-v$(get-current-version)-Setup.exe `
    -o "$name.exe"
7z x "./$name.exe" "-o$env:PREFIX/bin/$name"
# shortcut
New-Item $env:PREFIX/Menu -ItemType Directory
Copy-Item "$name.json" "$env:PREFIX/Menu"
