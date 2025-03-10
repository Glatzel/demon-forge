$origin_version=gh release view -R AcademySoftwareFoundation/OpenImageIO --json tagName -q .tagName
Write-Output "openimageio: $origin_version"

$current_versions=gh release view --json tagName -q .tagName
if("$current_versions".Contains($origin_version)){
  write-output "No new version found, skip build."
}
else{
  write-output "New version found."
}
