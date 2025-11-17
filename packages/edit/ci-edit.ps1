Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

$latest_version = get-version-github -repo "microsoft/$name"
$latest_version = "$latest_version".Replace("v", "")
update-recipe -version $latest_version

Remove-Item $ROOT/temp/$name -Recurse -ErrorAction SilentlyContinue
New-Item  $ROOT/temp/$name -ItemType Directory
if ($isWindows) {
    gh release download -R "microsoft/$name" -p "*x86_64-windows*" `
        -O  $ROOT/temp/$name/$name.zip --clobber
    7z x "$ROOT/temp/$name/$name.zip" "-o$ROOT/temp/$name"
}
if ($IsLinux -and ($arch -eq 'X64')) {
    gh release download -R "microsoft/$name" -p "*x86_64-linux*" `
        -O  $ROOT/temp/$name/$name.tar.zst --clobber
    tar  --zstd -xvf "$ROOT/temp/$name/$name.tar.zst" -C "$ROOT/temp/$name"
    Remove-Item "$ROOT/temp/$name/$name.tar.zst"
}
if ($IsLinux -and ($arch -eq 'Arm64')) {
    gh release download -R "microsoft/$name" -p "*aarch64-linux*" `
        -O  $ROOT/temp/$name/$name.tar.zst --clobber
    tar  --zstd -xvf "$ROOT/temp/$name/$name.tar.zst" -C "$ROOT/temp/$name"
    Remove-Item "$ROOT/temp/$name/$name.tar.zst"
}
build-pkg
