Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

Remove-Item $ROOT/temp/$name -Recurse -ErrorAction SilentlyContinue
New-Item $ROOT/temp/$name -ItemType Directory -ErrorAction SilentlyContinue
pixi run -e selenium python download.py

$zipfile = (Get-ChildItem "$ROOT/temp/$name/*.zip")[0]
$zipfile.BaseName -match "CrSDK_v(\d+)\.(\d+)\.(\d+).+_(\S+)"
$major = $Matches[1]
$minor = $Matches[2]
$patch = "$minor".Replace("00", "0")
$patch = $Matches[3]
$patch = "$patch".Replace("00", "0")
$latest_version = "$major.$minor.$patch"
$platform = $Matches[4]
foreach ($f in Get-ChildItem "$ROOT/temp/$name/*.zip") {
    $f.BaseName -match "CrSDK_v(\d+)\.(\d+)\.(\d+).+_(\S+)"
    $platform = $Matches[4]
    7z x "$f" "-o$ROOT/temp/$name/unzip/$platform"
}
update-recipe -version $latest_version

if ($IsLinux) {
    pixi run rattler-build build
    Write-Output "::group::linux arm64"
    $is_arm = $true
    sudo apt-get update
    sudo apt-get install -y qemu-user-static g++-aarch64-linux-gnu cmake ninja-build
    pixi run rattler-build build --target-platform linux-aarch64
    Write-Output "::endgroup::"
}
else {
    build-pkg
}
