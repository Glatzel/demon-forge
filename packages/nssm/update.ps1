$latest_version = get-version-url -url "https://nssm.cc/download" -pattern 'nssm (\d+\.\d+)'
update-recipe $latest_version
