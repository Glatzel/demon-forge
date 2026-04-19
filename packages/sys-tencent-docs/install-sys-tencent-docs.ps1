if (-not (Test-Path "C:\Program Files\TencentDocs\TencentDocs.exe"))
{
    winget install --source winget -i --id Tencent.QQ.NT
} else
{
    write-host "Tencent Docs is already installed."
}
