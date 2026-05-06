$latest_version = get-version-url -url "https://opendata.blender.org" -pattern 'benchmark-launcher-(\d+\.\d+\.\d+)'
update-recipe $latest_version
