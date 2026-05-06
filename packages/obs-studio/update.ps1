$latest_version = get-version-github -repo "obsproject/$name"
update-recipe $latest_version
