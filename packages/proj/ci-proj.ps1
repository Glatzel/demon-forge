Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

& $PSScriptRoot/../proj_build/vcpkg-setup.ps1
& $PSScriptRoot/../proj_build/vcpkg-install.ps1

Set-Location $PSScriptRoot
build-pkg

# linux-arm64
if ($IsLinux) {
    sudo apt-get update
    sudo apt-get install -y qemu-user-static g++-aarch64-linux-gnu cmake ninja-build
    & $PSScriptRoot/../proj_build/vcpkg-install-arm.ps1
    pixi run rattler-build build --target-platform linux-aarch64
}
