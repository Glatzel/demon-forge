$env:CARGO_PROFILE_RELEASE_STRIP= "symbols"
Copy-Item $env:RECIPE_DIR/win/etc/ $env:PREFIX/ -recurse
just assemble-codex-package --cargo-profile release --package-dir ./out --target x86_64-pc-windows-msvc
Copy-Item ./out/* $env:PREFIX/ -Recurse -Force
# Pixi: prevent CONDA_PREFIX from leaking into sandboxed processes

$markerDir = Join-Path $env:PREFIX 'etc/pixi/codex'
New-Item -ItemType Directory -Path $markerDir -Force | Out-Null
New-Item -ItemType File -Path (Join-Path $markerDir 'global-ignore-conda-prefix') -Force | Out-Null
