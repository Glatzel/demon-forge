$url = &vinaya.exe sidefx `
    download.get-daily-build-download `
    houdini-launcher `
    "$env:PKG_VERSION" `
    production `
    win64 `
    | jq -r '.download_url'
Write-Output $url
aria2c -c -x16 -s16 "$url" -o houdini-launcher.exe
new-item -itemtype directory -path $env:PREFIX/houdini-launcher
& ./houdini-launcher.exe /S /D=$(Resolve-Path $env:PREFIX/houdini-launcher)

new-item -itemtype directory -path $env:PREFIX/bin
new-item -Path $env:PREFIX/bin/houdini_launcher.exe -Target "../houdini-launcher/bin/houdini_launcher.exe" -ItemType SymbolicLink

# shortcut
New-Item $env:PREFIX/Menu -ItemType Directory
Copy-Item "${env:RECIPE_DIR}/${env:PKG_NAME}.json" "$env:PREFIX/Menu"
