$latest_version = get-version-github -repo "$name/$name"
$latest_version = "$latest_version".Replace("release-", "")
update-recipe $latest_version
