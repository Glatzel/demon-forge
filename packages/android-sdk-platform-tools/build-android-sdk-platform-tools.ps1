$ROOT = git rev-parse --show-toplevel
New-Item $env:PREFIX/bin/android-sdk-platform-tools -ItemType Directory
Copy-Item "$ROOT/temp/android-sdk-platform-tools/platform-tools/*" "$env:PREFIX/bin/android-sdk-platform-tools"
