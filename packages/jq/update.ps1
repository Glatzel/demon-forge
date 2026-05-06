$latest_version = get-version-github -repo "jqlang/$name"
$latest_version = "$latest_version".Replace("$name-", "")
update-recipe $latest_version
