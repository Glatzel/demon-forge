Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

$latest_version = get-latest-version -repo "svenstaro/$name"
$latest_version = "$latest_version".Replace("v", "")

Remove-Item $ROOT/temp/$name -Recurse -ErrorAction SilentlyContinue
New-Item  $ROOT/temp/$name -ItemType Directory
if ($IsWindows) {
    gh release download -R "svenstaro/$name" -p "$name-*-x86_64-pc-windows-msvc.exe" `
        -O  $ROOT/temp/$name/$name.exe --clobber
}
if ($IsMacOS) {
    gh release download -R "svenstaro/$name" -p "$name-*-aarch64-apple-darwin" `
        -O  $ROOT/temp/$name/$name --clobber
}
if ($IsLinux) {
    gh release download -R "svenstaro/$name" -p "$name-*-x86_64-unknown-linux-musl
" `
        -O  $ROOT/temp/$name/$name --clobber
}
update-recipe -version $latest_version
build-pkg

#linux aarch
Remove-Item $ROOT/temp/$name -Recurse -ErrorAction SilentlyContinue
New-Item  $ROOT/temp/$name -ItemType Directory
{
    gh release download -R "svenstaro/$name" -p "$name-*-aarch64-unknown-linux-musl" `
        -O  $ROOT/temp/$name/$name --clobber
    pixi run rattler-build build --target-platform linux-aarch64
}
