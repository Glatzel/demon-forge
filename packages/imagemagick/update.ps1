$latest_version = get-version-github -repo "ImageMagick/ImageMagick"
$latest_version = "$latest_version".Replace("-", ".")
update-recipe $latest_version
