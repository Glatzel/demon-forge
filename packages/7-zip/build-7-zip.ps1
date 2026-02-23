New-Item $env:PREFIX/bin -ItemType Directory
$src = if ($IsWindows) { "7zz.exe" } else { "7zz" }
$dst = if ($IsWindows) { "7z.exe" } else { "7z" }
Copy-Item "$env:BUILD_PREFIX/bin/$src" "$env:PREFIX/bin/$dst"
