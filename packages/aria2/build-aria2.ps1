$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

gh release download -R $name/$name -p "$name-*-win-64bit*.zip" `
    -O  ./$name.zip --clobber
7z x "./$name.zip" "-o./$name"
New-Item $env:PREFIX/bin -ItemType Directory
Copy-Item "./$name/*/aria2c.exe" "$env:PREFIX/bin/aria2c.exe"
