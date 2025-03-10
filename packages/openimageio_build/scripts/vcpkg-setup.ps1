Set-Location $PSScriptRoot
Set-Location ..
git clone https://github.com/microsoft/vcpkg.git --depth 1
./vcpkg/bootstrap-vcpkg.bat
