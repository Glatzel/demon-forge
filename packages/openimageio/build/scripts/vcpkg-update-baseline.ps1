Set-Location $PSScriptRoot

./vcpkg-setup.ps1
Set-Location $PSScriptRoot/../ocio
& $PSScriptRoot/../vcpkg/vcpkg.exe x-update-baseline
