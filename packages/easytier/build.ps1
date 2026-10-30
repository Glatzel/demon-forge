$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
cargo-build --git https://github.com/EasyTier/EasyTier --tag "v$env:PKG_VERSION" easytier
gh api repos/EasyTier/EasyTier/contents/easytier/third_party/x86_64/Packet.dll --jq '.content' | base64 -d > $env:PREFIX/bin/Packet.dll
gh api repos/EasyTier/EasyTier/contents/easytier/third_party/x86_64/wintun.dll --jq '.content' | base64 -d > $env:PREFIX/bin/wintun.dll
