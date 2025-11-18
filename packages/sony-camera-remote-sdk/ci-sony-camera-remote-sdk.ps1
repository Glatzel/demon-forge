Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
create-temp -name $name
$latest_version = get-version-url -url "https://support.d-imaging.sony.co.jp/app/sdk/licenseagreement_d/en-US.html" -pattern 'CrSDK_v(\d+\.\d+\.\d+)_'
$latest_version = "$latest_version".Replace("00", "0")
update-recipe -version $latest_version

pixi run -e selenium python download.py

$zipfile = (Get-ChildItem "$ROOT/temp/$name/*.zip")[0]
$zipfile.BaseName -match "CrSDK_v(\d+)\.(\d+)\.(\d+).+_(\S+)"
$platform = $Matches[4]
foreach ($f in Get-ChildItem "$ROOT/temp/$name/*.zip") {
    $f.BaseName -match "CrSDK_v(\d+)\.(\d+)\.(\d+).+_(\S+)"
    $platform = $Matches[4]
    7z x "$f" "-o$ROOT/temp/$name/unzip/$platform"
}

if ($IsLinux) {
    pixi run rattler-build build
    Write-Output "::group::linux arm64"
    $is_arm = $true
    pixi run rattler-build build --target-platform linux-aarch64
    Write-Output "::endgroup::"
}
else {
    build-pkg
}
