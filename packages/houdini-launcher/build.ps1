$url = &vinaya.exe sidefx `
    download.get-daily-build-download `
    --product houdini-launcher `
    --version 20.5 `
    --build production `
    --platform win64 `
    --jq '.download_url'
aria2c -c -x16 -s16 "$url" -o houdini-launcher.exe
new-item -itemtype directory -path $env:PREFIX/houdini-launcher
& ./houdini-launcher.exe /S /D=$(Resolve-Path $env:PREFIX/houdini-launcher)
