$ROOT = git rev-parse --show-toplevel

New-Item $env:PREFIX/bin/$name -ItemType Directory
Copy-Item "$ROOT/temp/$name/bin/Mason/*" "$env:PREFIX/bin/$name" -Recurse
