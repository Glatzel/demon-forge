$SourceDir   = "$PSScriptRoot/../fonts"
$Destination = (New-Object -ComObject Shell.Application).Namespace(0x14)

Get-ChildItem -Path $SourceDir/* -Include '*.ttf','*.ttc','*.otf' -Recurse | ForEach-Object {
    If (-not(Test-Path "C:\Windows\Fonts\$($_.Name)")) {
        $Font = "$PSScriptRoot/../fonts/$($_.Name)"
        $Destination.CopyHere($Font,0x10)
        write-output "Installed font: $($_.Name)"
    }
    else {
        write-output "Font already installed: $($_.Name)"
    }
}
