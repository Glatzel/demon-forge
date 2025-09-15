param($version = "")
if($version -eq '')
{
    $version=gh release view -R AcademySoftwareFoundation/OpenImageIO --json tagName -q .tagName
}
Set-Location $PSScriptRoot
Set-Location ..

Remove-Item external -Force -Recurse -ErrorAction SilentlyContinue
New-Item external -ItemType Directory -ErrorAction SilentlyContinue
Set-Location external

Write-Output "::group::clone OpenImageIO"
git clone https://github.com/AcademySoftwareFoundation/OpenImageIO.git
Set-Location OpenImageIO
git checkout tags/"$version" -b "$version-branch"

# copy dependencies to install dir
"install(FILES $<TARGET_RUNTIME_DLLS:iconvert> TYPE BIN)" >> CmakeLists.txt
"install(FILES $<TARGET_RUNTIME_DLLS:idiff> TYPE BIN)" >> CmakeLists.txt
"install(FILES $<TARGET_RUNTIME_DLLS:igrep> TYPE BIN)" >> CmakeLists.txt
"install(FILES $<TARGET_RUNTIME_DLLS:iinfo> TYPE BIN)" >> CmakeLists.txt
"install(FILES $<TARGET_RUNTIME_DLLS:maketx> TYPE BIN)" >> CmakeLists.txt
"install(FILES $<TARGET_RUNTIME_DLLS:oiiotool> TYPE BIN)" >> CmakeLists.txt
Set-Location ..
Write-Output "::endgroup::"
