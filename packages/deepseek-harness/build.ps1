$ErrorActionPreference = "Stop"

$installDir = Join-Path $env:PREFIX "lib\dsh"
$binDir = Join-Path $env:PREFIX "bin"
New-Item -ItemType Directory -Path $installDir -Force | Out-Null
New-Item -ItemType Directory -Path $binDir -Force | Out-Null

npm install `
    --prefix $installDir `
    --cache ".\npm-cache" `
    --omit=dev `
    --no-audit `
    --no-fund `
    "@deepseek-ai/dsh@latest"
if ($LASTEXITCODE -ne 0) {
    throw "npm install failed with exit code $LASTEXITCODE"
}

$cmdContent = @'
@echo off
if exist "%~dp0..\node.exe" (
  "%~dp0..\node.exe" "%~dp0..\lib\dsh\node_modules\@deepseek-ai\dsh\lib\bin.js" %*
) else (
  node "%~dp0..\lib\dsh\node_modules\@deepseek-ai\dsh\lib\bin.js" %*
)
'@
Set-Content -Path (Join-Path $binDir "dsh.cmd") -Value $cmdContent -Encoding Ascii
