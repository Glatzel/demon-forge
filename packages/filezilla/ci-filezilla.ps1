Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
$latest_version = get-version-url -url "https://filezilla-project.org/newsfeed.php" -pattern 'FileZilla Client (\d+\.\d+\.\d+) released'
update-recipe -version $latest_version

