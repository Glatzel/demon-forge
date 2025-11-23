New-Item $env:PREFIX/bin/openimageio -ItemType Directory
Copy-Item "$ROOT/temp/$name/dist/*" "$env:PREFIX/bin/openimageio"
