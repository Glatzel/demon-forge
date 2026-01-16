$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

gh release download -R https://github.com/kovidgoyal/$name -p "$name-portable*" `
    -O  ./$name.exe --clobber
Remove-Item C:/temp -Recurse -ErrorAction SilentlyContinue
New-Item  C:/temp -ItemType Directory
Start-Process -FilePath "./$name.exe" -ArgumentList "C:/temp" -Wait
New-Item $env:PREFIX/bin/$name -ItemType Directory
Copy-Item "C:/temp/Calibre Portable/*" "$env:PREFIX/bin/$name" -Recurse
# shortcut
New-Item $env:PREFIX/Menu -ItemType Directory
Copy-Item "$name.json" "$env:PREFIX/Menu"
