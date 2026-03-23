$version = "18.2.2"
if (-not (Test-Path "C:/Program Files/Adobe/Adobe DNG Converter/Adobe DNG Converter.exe")) {
    $need_install = $true
}
else {
    if ((Get-Item "C:/Program Files/Adobe/Adobe DNG Converter/Adobe DNG Converter.exe").VersionInfo.ProductVersion -ne "$version") {
        $need_install = $true
    }
}
if ( $need_install) {
    if (-not (Test-Path "./temp/dnc$version.exe")) {
        Write-Output "download dnc $version"
        aria2c -c -x16 -s16 `
            -d "./temp" `
            "https://download.adobe.com/pub/adobe/dng/win/AdobeDNGConverter_x64_$version.exe" `
            -o "dnc$version.exe"

    }
    Write-Output "install dnc $version"
    Start-Process "./temp/dnc$version.exe" -ArgumentList "/silent" -Wait
    Write-Output "dnc installed"
}
