Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
$latest_version = get-version-url -url "https://support.d-imaging.sony.co.jp/app/sdk/licenseagreement_d/en-US.html" -pattern 'CrSDK_v(\d+\.\d+\.\d+)_'
$latest_version = "$latest_version".Replace("00", "0")
update-recipe -version $latest_version
build-pkg

