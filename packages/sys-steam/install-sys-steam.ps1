if (-not (Test-Path "C:\Program Files (x86)\Steam\steam.exe"))
{
    winget install --source winget -i --id Valve.Steam
}
