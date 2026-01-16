$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

aria2c -c -x16 -s16 -d ./ `
    "https://dist.$name.org/win-x86-commandline/latest/$name.exe" `
    -o "$name.exe"
New-Item $env:PREFIX/bin -ItemType Directory
Copy-Item "./$name/$name.exe" "$env:PREFIX/bin/$name.exe"
