$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

aria2c -c -x16 -s16 -d ./ `
    "https://googledownloads.cn/android/repository/platform-tools-latest-windows.zip" `
    -o "$name.zip"
7z x "./$name.zip" "-o./$name"
New-Item $env:PREFIX/bin -ItemType Directory
Copy-Item "./$name/platform-tools/*" "$env:PREFIX/bin" -recurse
