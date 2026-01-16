$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

gh release download -R "pbatard/$name" -p "$name-*.??.exe" `
    -O  ./$name.exe --clobber
New-Item $env:PREFIX/bin -ItemType Directory
Copy-Item "./$name/$name.exe" "$env:PREFIX/bin/$name.exe"
# shortcut
New-Item $env:PREFIX/Menu -ItemType Directory
Copy-Item "$name.json" "$env:PREFIX/Menu"
