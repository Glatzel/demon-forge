$version=[version]"$env:PKG_VERSION"
$url = &vinaya.exe sidefx `
    download.get-daily-build-download `
    --product houdini-launcher `
    --major $version.Major `
    --minor $version.Minor `
    --build production `
    --platform win64 `
    | jq -r '.download_url'
Write-Output $url
aria2c -c -x16 -s16 "$url" -o houdini-launcher.exe
new-item -itemtype directory -path $env:PREFIX/houdini-launcher
& ./houdini-launcher.exe /S /D=$(Resolve-Path ./)
copy-item -path ./$version/* -destination $env:PREFIX/houdini-launcher -Recurse
