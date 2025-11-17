Set-Location $PSScriptRoot
Remove-Item vcpkg -Recurse -Force -ErrorAction SilentlyContinue
git clone https://github.com/microsoft/vcpkg.git
if ($IsWindows) {
    ./vcpkg/bootstrap-vcpkg.bat
}
else {
    ./vcpkg/bootstrap-vcpkg.sh
}
Set-Location $PSScriptRoot
./vcpkg/vcpkg.exe x-update-baseline
