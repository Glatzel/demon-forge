Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

# process version
$latest_version = get-latest-version -repo "AcademySoftwareFoundation/oiiotool"
$latest_version = "$latest_version".Replace("v","")

#pre-build
Remove-Item $PSScriptRoot/../oiiotool_build/external -Recurse -ErrorAction SilentlyContinue
Remove-Item $PSScriptRoot/../oiiotool_build/vcpkg -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item $PSScriptRoot/../oiiotool_build/dist -Recurse -ErrorAction SilentlyContinue
& $PSScriptRoot/../oiiotool_build/scripts/pixi-setup.ps1
& $PSScriptRoot/../oiiotool_build/scripts/clone-repo.ps1
& $PSScriptRoot/../oiiotool_build/scripts/vcpkg-setup.ps1
& $PSScriptRoot/../oiiotool_build/scripts/vcpkg-install.ps1
& $PSScriptRoot/../oiiotool_build/scripts/build-ocio.ps1
& $PSScriptRoot/../oiiotool_build/scripts/build-oiio.ps1
& $PSScriptRoot/../oiiotool_build/scripts/copy-item.ps1

#rattler build
Set-Location $PSScriptRoot
update-recipe -version $latest_version
build-pkg
