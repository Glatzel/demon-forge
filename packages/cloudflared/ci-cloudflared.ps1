Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

$latest_version = get-latest-version -repo "cloudflare/$name"
update-recipe -version $latest_version

Remove-Item $ROOT/temp/$name -Recurse -ErrorAction SilentlyContinue
New-Item  $ROOT/temp/$name -ItemType Directory
if ($IsWindows) {
    gh release download -R "cloudflare/$name" -p "$name-windows-amd64.exe" `
        -O  $ROOT/temp/$name/$name.exe --clobber
}
if ($IsLinux) {
    gh release download -R "cloudflare/$name" -p "$name-linux-amd64" `
        -O  $ROOT/temp/$name/$name --clobber
}
build-pkg

# aarch64
if ($IsLinux) {
    Remove-Item $ROOT/temp/$name -Recurse -ErrorAction SilentlyContinue
    New-Item  $ROOT/temp/$name -ItemType Directory
    gh release download -R "cloudflare/$name" -p "$name-linux-arm64" `
        -O  $ROOT/temp/$name/$name --clobber
    pixi run rattler-build build --target-platform linux-aarch64
}
