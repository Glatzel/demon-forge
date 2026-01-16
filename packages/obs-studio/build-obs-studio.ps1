$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1


gh release download -R obsproject/$name -p "*-Windows-x64.zip" `
    -O  ./$name.zip --clobber
7z x "./$name.zip" "-o./$name"
New-Item $env:PREFIX/bin/$name -ItemType Directory
Copy-Item "./$name/$name/*" "$env:PREFIX/bin/$name" -Recurse
# shortcut
New-Item $env:PREFIX/Menu -ItemType Directory
Copy-Item "$name.json" "$env:PREFIX/Menu"
