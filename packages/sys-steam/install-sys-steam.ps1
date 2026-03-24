$template_version
if (-not (Test-Path "C:\Program Files\Rhino 8\System\Rhino.exe")) {
    if (-not (Test-Path "$PSScriptRoot/../temp/steam.exe")) {
        & "$PSScriptRoot/../bin/aria2c.exe" -c -x16 -s16 `
            -d "$PSScriptRoot/../temp" `
            "http://cdn.akamai.steamstatic.com/client/installer/SteamSetup.exe" `
            -o "steam.exe"
    }
    Write-Output "install rhino $version"
    Start-Process "$PSScriptRoot/../temp/steam.exe" -ArgumentList "/S" -Wait
    Write-Output "rhino installed"
}
