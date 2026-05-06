$latest_version = get-version-url -url "https://www.cpuid.com/softwares/cpu-z.html" -pattern 'cpu-z_(\d+\.\d+)-en.zip'
update-recipe $latest_version
