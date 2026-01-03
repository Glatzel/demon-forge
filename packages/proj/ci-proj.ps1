Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
$latest_version = get-version-vcpkg -name $name
update-recipe -version $latest_version
update-vcpkg-json -file $PSScriptRoot/build/vcpkg.json -name $name -version $latest_version
if ($IsLinux) {
    dnf update -y
    dnf install -y gcc-toolset-10-gcc gcc-toolset-10-gcc-c++ cmake make
}
Copy-Item $PSScriptRoot/build/* $ROOT/temp/$name/ -Recurse
& $ROOT/temp/$name/vcpkg-setup.ps1
& $ROOT/temp/$name/vcpkg-install.ps1

Set-Location $PSScriptRoot
build-pkg
