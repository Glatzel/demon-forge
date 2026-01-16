$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

aria2c -c -x16 -s16 -d ./ `
    "https://download.librepcb.org/releases/$(get-current-version)/librepcb-$(get-current-version)-windows-x86_64.zip" `
    -o "$name.zip"
7z x "./$name.zip" "-o./$name"
New-Item $env:PREFIX/bin/$name -ItemType Directory
Copy-Item "./$name/$name/*" "$env:PREFIX/bin/$name" -Recurse
# shortcut
New-Item $env:PREFIX/Menu -ItemType Directory
Copy-Item "$name.json" "$env:PREFIX/Menu"
