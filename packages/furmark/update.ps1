$latest_version = get-version-url -url "https://geeks3d.com/furmark/changelog/" -pattern 'version (\d+\.\d+\.\d+\.*\d*)'
update-recipe $latest_version
