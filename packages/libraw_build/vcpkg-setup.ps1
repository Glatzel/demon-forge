Set-Location $PSScriptRoot

Remove-Item vcpkg -Recurse -Force -ErrorAction SilentlyContinue
git clone https://github.com/microsoft/vcpkg.git
if ($IsWindows) {
    ./vcpkg/bootstrap-vcpkg.bat
}
if ($IsLinux) {
    ./vcpkg/bootstrap-vcpkg.sh
}
