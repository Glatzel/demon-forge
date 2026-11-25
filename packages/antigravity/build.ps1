$ErrorActionPreference = "Stop"

$DOWNLOAD_BASE_URL = "https://antigravity-cli-auto-updater-974169037036.us-central1.run.app"
$MANIFEST_URL = "$DOWNLOAD_BASE_URL/manifests/windows_amd64.json"

$manifest = Invoke-RestMethod -Uri $MANIFEST_URL
$url = $manifest.url
$sha512 = $manifest.sha512

if ([string]::IsNullOrWhiteSpace($url) -or [string]::IsNullOrWhiteSpace($sha512)) {
    throw "Failed to parse manifest from $MANIFEST_URL"
}

$binDir = Join-Path $env:PREFIX "bin"
New-Item -ItemType Directory -Path $binDir -Force | Out-Null

$targetPath = Join-Path $binDir "agy.exe"
$ProgressPreference = "SilentlyContinue"
Invoke-WebRequest -Uri $url -OutFile $targetPath -UseBasicParsing

$actualHash = (Get-FileHash -Path $targetPath -Algorithm SHA512).Hash.ToLower()
if ($actualHash -ne $sha512.ToLower()) {
    throw "SHA512 mismatch: expected $($sha512.ToLower()), got $actualHash"
}
