Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

$latest_version = get-latest-version -repo "https://github.com/$name/$name"
$latest_version = "$latest_version".Replace("v", "")
Remove-Item $ROOT/temp/$name -Recurse -ErrorAction SilentlyContinue
New-Item  $ROOT/temp/$name -ItemType Directory
if ($IsWindows) {
    gh release download -R $name/$name -p "*-win64.zip" `
        -O  $ROOT/temp/$name/$name.zip --clobber
    7z x "$ROOT/temp/$name/$name.zip" "-o$ROOT/temp/$name/$name"
}
# if ($IsLinux) {
#     gh release download -R obsproject/$name -p "*-amd64-linux.tar.xz" `
#         -O  $ROOT/temp/$name/$name.tar.xz --clobber
#     7z x "$ROOT/temp/$name/$name.tar.xz" "-o$ROOT/temp/$name/$name"
# }

update-recipe -version $latest_version
build-pkg
