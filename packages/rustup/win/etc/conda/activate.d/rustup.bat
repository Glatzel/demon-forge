@echo off
setlocal

powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0rustup.ps1"

if errorlevel 1 (
    echo Failed to create Rust symbolic links.
    exit /b 1
)

endlocal
