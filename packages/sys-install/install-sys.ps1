foreach ($f in Get-ChildItem $PSScriptRoot/sys-install-*.ps1) {
    $pkg_name = ([System.IO.Path]::GetFileNameWithoutExtension($f)).Replace("sys-install-", "")
    Write-Output "Install $pkg_name"
    & $f
}
