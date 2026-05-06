$latest_version = get-version-url -url "https://www.hwinfo.com/news.xml/" -pattern 'HWiNFO v(\d+\.\d+) released'
update-recipe $latest_version
