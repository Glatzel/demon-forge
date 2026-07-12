$template_version
if (-not (Test-Path "$env:USERPROFILE\AppData\Roaming\Autodesk\ApplicationPlugins\Rhino.Inside.AutoCAD.bundle"))
{
    $need_install = $true
} else
{
    [xml]$xml = Get-Content "C:\Users\Glatzel\AppData\Roaming\Autodesk\ApplicationPlugins\Rhino.Inside.AutoCAD.bundle\PackageContents.xml"
    if ($xml.ApplicationPackage.AppVersion -ne "$version")
    {
        $need_install = $true
    } else
    { Write-Output "rhino.inside-autocad $version is already installed."
    }
}
if ( $need_install)
{
    if (-not (Test-Path "$PSScriptRoot/../temp/rhino-$version.exe"))
    {
        & "$PSScriptRoot/../bin/aria2c.exe" -c -x16 -s16 `
            -d "$PSScriptRoot/../temp" `
            "https://github.com/mcneel/rhino.inside-autocad/releases/download/v1.2.28/Rhino.Inside.AutoCAD.and.Civil3D.Installer.V$version.msi" `
            -o "rhino-inside-autocad-$version.msi"
    }
    Write-Output "install rhino.inside-autocad $version"
    Start-Process "$PSScriptRoot/../temp/rhino-inside-autocad-$version.msi"
    Write-Output "rhino.inside-autocad installed"
}
