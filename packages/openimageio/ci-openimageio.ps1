Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

# process version
$latest_version = get-latest-version -repo "AcademySoftwareFoundation/OpenImageIO"
$latest_version = "$latest_version".Replace("v","")
update-recipe -version $latest_version

#pre-build
Remove-Item $PSScriptRoot/../openimageio_build/external -Recurse -ErrorAction SilentlyContinue
Remove-Item $PSScriptRoot/../openimageio_build/vcpkg -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item $PSScriptRoot/../openimageio_build/dist -Recurse -ErrorAction SilentlyContinue
& $PSScriptRoot/../openimageio_build/scripts/pixi-setup.ps1
& $PSScriptRoot/../openimageio_build/scripts/clone-repo.ps1
& $PSScriptRoot/../openimageio_build/scripts/vcpkg-setup.ps1
& $PSScriptRoot/../openimageio_build/scripts/vcpkg-install.ps1
& $PSScriptRoot/../openimageio_build/scripts/build-oiio.ps1
& $PSScriptRoot/../openimageio_build/scripts/copy-item.ps1

#rattler build
Set-Location $PSScriptRoot
build-pkg
