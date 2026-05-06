$latest_version = get-version-github -repo "akinomyoga/ble.sh"
update-recipe $latest_version.Split('-')[0]
