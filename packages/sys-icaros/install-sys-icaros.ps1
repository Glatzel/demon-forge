if (-not (Test-Path "C:\Program Files\Icaros\IcarosConfig.exe"))
{
    winget install --source winget -i --id Xanashi.Icaros
}
