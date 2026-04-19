if (-not (Test-Path "C:\Program Files\Microsoft VS Code\Code.exe"))
{
    winget install --source winget -i --id Microsoft.VisualStudioCode
} else
{
    write-host "VsCode is already installed."
}
