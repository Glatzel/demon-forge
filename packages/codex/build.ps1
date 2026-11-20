tree /f
Copy-Item ./* $env:PREFIX/ -Recurse -Force
# Pixi: prevent CONDA_PREFIX from leaking into sandboxed processes
$markerDir = Join-Path $env:PREFIX 'etc/pixi/codex'
New-Item -ItemType Directory -Path $markerDir -Force | Out-Null
New-Item -ItemType File -Path (Join-Path $markerDir 'global-ignore-conda-prefix') -Force | Out-Null
