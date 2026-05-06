$latest_version = get-version-github -repo "$name/$name"
update-recipe $latest_version
