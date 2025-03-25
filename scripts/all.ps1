Set-Location $PSScriptRoot/..
foreach ($f in Get-ChildItem "./packages/*/ci-*.ps1") {
   & $f
}
