foreach ($f in Get-ChildItem $PSScriptRoot/install-sys-*.ps1)
{
    $pkg_name = ([System.IO.Path]::GetFileNameWithoutExtension($f)).Replace("install-sys-", "")
    Write-Output "===================Install $pkg_name=========================="
    & $f
}
