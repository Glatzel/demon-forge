$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

aria2c --max-tries=5 --retry-wait=10 -c -x16 -s16 -d "./" `
    "https://nssm.cc/release/nssm-$(get-current-version).zip" `
    -o "$name.zip"

7z x "./$name.zip" "-o./$name"
New-Item $env:PREFIX/bin -ItemType Directory
Copy-Item "./$name/$name/$name*/Win64/$name.exe" "$env:PREFIX/bin/$name.exe"
