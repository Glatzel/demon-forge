$template_version
if (-not (Test-Path "C:\Program Files\Rhino 8\System\Rhino.exe")) {
    $need_install = $true
}
else {
    if ((Get-Item "C:\Program Files\Rhino 8\System\Rhino.exe").VersionInfo.ProductVersion -ne "$version") {
        $need_install = $true
    }
    else{Write-Output "rhino $version is already installed."}
}
if ( $need_install) {
    if (-not (Test-Path "$PSScriptRoot/../temp/rhino-$version.exe")) {
        & "$PSScriptRoot/../bin/aria2c.exe" -c -x16 -s16 `
            -d "$PSScriptRoot/../temp" `
            "https://www.rhino3d.com/download/rhino-for-windows/8/latest/direct?email=users.noreply.github.com" `
            -o "rhino-$version.exe"
    }
    Write-Output "install dnc $version"
    Start-Process "$PSScriptRoot/../temp/rhino-$version.exe" -ArgumentList "/silent" -Wait
    Write-Output "rhino installed"
}
