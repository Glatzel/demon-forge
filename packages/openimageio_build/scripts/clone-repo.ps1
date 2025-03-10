param($version = "")
if($version -eq '')
{
    $version=gh release view -R AcademySoftwareFoundation/OpenImageIO --json tagName -q .tagName
}
Set-Location $PSScriptRoot
Set-Location ..
$patch_libraw = Resolve-Path ./patch/fix_libraw.patch

Remove-Item external -Force -Recurse -ErrorAction SilentlyContinue
New-Item external -ItemType Directory
Set-Location external

Write-Output "::group::clone OpenImageIO"
git clone https://github.com/AcademySoftwareFoundation/OpenImageIO.git
Set-Location OpenImageIO
git checkout tags/"$version" -b "$version-branch"
 # apply patch
git apply -v $patch_libraw
# copy dependencies to install dir
"install(FILES $<TARGET_RUNTIME_DLLS:iconvert> TYPE BIN)" >> CmakeLists.txt
"install(FILES $<TARGET_RUNTIME_DLLS:idiff> TYPE BIN)" >> CmakeLists.txt
"install(FILES $<TARGET_RUNTIME_DLLS:igrep> TYPE BIN)" >> CmakeLists.txt
"install(FILES $<TARGET_RUNTIME_DLLS:iinfo> TYPE BIN)" >> CmakeLists.txt
"install(FILES $<TARGET_RUNTIME_DLLS:maketx> TYPE BIN)" >> CmakeLists.txt
"install(FILES $<TARGET_RUNTIME_DLLS:oiiotool> TYPE BIN)" >> CmakeLists.txt
Set-Location ..
Write-Output "::endgroup::"

Write-Output "::group::clone OpenColorIO"
git clone https://github.com/AcademySoftwareFoundation/OpenColorIO.git
Set-Location OpenColorIO
git checkout tags/v2.3.2 -b v2.3.2-branch
Set-Location ..
Write-Output "::endgroup::"
