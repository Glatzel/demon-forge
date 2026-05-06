$latest_version = get-version-github -repo "cloudflare/$name"
update-recipe $latest_version
