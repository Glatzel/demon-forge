if (-not (Test-Path "C:\Program Files\Tencent\QQNT\QQ.exe"))
{
    winget install --source winget -i --id Tencent.QQ.NT
} else
{
    write-host "QQ is already installed."
}
