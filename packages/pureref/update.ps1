$latest_version = get-version-url -url "https://www.pureref.com/download.php" -pattern 'selected value="(\d+\.\d+\.\d+)"'
update-recipe $latest_version
