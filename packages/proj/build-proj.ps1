Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
if ($IsLinux) {
    dnf update -y
    dnf install -y gcc-toolset-10-gcc gcc-toolset-10-gcc-c++
    $env:PATH = "/opt/rh/gcc-toolset-10/root/usr/bin`:$env:PATH"
    $env:LD_LIBRARY_PATH = "/opt/rh/gcc-toolset-10/root/usr/lib64`:$env:LD_LIBRARY_PATH"
    $env:CXX = "g++"
    $env:CC = "gcc"
    gcc --version
    g++ --version
}
Copy-Item $PSScriptRoot/build/* $ROOT/temp/$name/ -Recurse
& $ROOT/temp/$name/vcpkg-setup.ps1
& $ROOT/temp/$name/vcpkg-install.ps1
New-Item $env:PREFIX/$name -ItemType Directory
Copy-Item "$ROOT/temp/$name/installed/*" "$env:PREFIX/$name" -Recurse
