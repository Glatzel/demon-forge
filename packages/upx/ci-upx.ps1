Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
$latest_version = get-version-github -repo "https://github.com/$name/$name"
update-recipe -version $latest_version
create-temp -name $name

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

build-pkg
