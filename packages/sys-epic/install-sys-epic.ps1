if (-not (Test-Path "C:\Program Files (x86)\Epic Games\Launcher\Portal\Binaries\Win32\EpicGamesLauncher.exe"))
{
    winget install --source winget -i --id EpicGames.EpicGamesLauncher
}
