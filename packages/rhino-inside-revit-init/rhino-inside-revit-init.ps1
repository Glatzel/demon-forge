$template_version
if (-not (Test-Path "C:\ProgramData\Autodesk\Revit\Addins\*\RhinoInside.Revit\RhinoInside.Revit.Loader.dll")) {
    $need_install = $true
}
else {
    if ((Get-Item "c:\ProgramData\Autodesk\Revit\Addins\*\RhinoInside.Revit\RhinoInside.Revit.Loader.dll").VersionInfo.FileVersion[0] -ne "$version") {
        $need_install = $true
    }
    else { Write-Output "rhino $version is already installed." }
}
if ( $need_install) {
    if (-not (Test-Path "$PSScriptRoot/../temp/rhino-$version.exe")) {
        & "$PSScriptRoot/../bin/aria2c.exe" -c -x16 -s16 `
            -d "$PSScriptRoot/../temp" `
            "https://files.mcneel.com/rhino.inside/revit/dujour/RhinoInside.Revit_$version.msi" `
            -o "rhino-$version.exe"
    }
    Write-Output "install rhino $version"
    Start-Process "$PSScriptRoot/../temp/rhino-$version.exe" -ArgumentList "/silent" -Wait
    Write-Output "rhino installed"
}
