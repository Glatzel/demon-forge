New-Item $env:PREFIX/bin -ItemType Directory
Copy-Item "./*" "$env:PREFIX/bin" -recurse
