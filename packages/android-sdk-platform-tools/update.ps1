$latest_version = get-version-url -url "https://developer.android.com/tools/releases/platform-tools" -pattern '([0-9]+\.[0-9]+\.[0-9]+)'
update-recipe $latest_version
