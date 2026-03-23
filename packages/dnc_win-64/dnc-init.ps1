$template_version
if (-not (Test-Path "C:/Program Files/Adobe/Adobe DNG Converter/Adobe DNG Converter.exe")) {
    $need_install = $true
}
else {
    if ((Get-Item "C:/Program Files/Adobe/Adobe DNG Converter/Adobe DNG Converter.exe").VersionInfo.ProductVersion -ne "$version") {
        $need_install = $true
    }
}
if ( $need_install) {
    if (-not (Test-Path "$env:PREFIX/temp/dnc$version.exe")) {
        $web_version = "$version".Replace(".", "_")
        Write-Output "download dnc $version"
        & "$PSScriptRoot/../bin/aria2c.exe" -c -x16 -s16 `
            -d "$PSScriptRoot/../temp" `
            "https://download.adobe.com/pub/adobe/dng/win/AdobeDNGConverter_x64_$web_version.exe" `
            -o "dnc$version.exe"
    }
    Write-Output "install dnc $version"
    Start-Process "$PSScriptRoot/../temp/dnc$version.exe" -ArgumentList "/silent" -Wait
    Write-Output "dnc installed"
}
