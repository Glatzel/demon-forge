$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

if ($IsWindows) {
    gh release download -R $name/$name -p "*-win64.zip" `
        -O  ./$name.zip --clobber
    7z x "./$name.zip" "-o./$name"
}
# if ($IsLinux) {
#     gh release download -R obsproject/$name -p "*-amd64-linux.tar.xz" `
#         -O  ./$name.tar.xz --clobber
#     7z x "./$name.tar.xz" "-o./$name"
# }
New-Item $env:PREFIX/bin/$name -ItemType Directory
Copy-Item "./$name/$name/$name*/*" "$env:PREFIX/bin/$name" -Recurse
