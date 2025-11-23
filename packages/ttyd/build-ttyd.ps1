Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

New-Item $env:PREFIX/bin -ItemType Directory
switch($env:TARGET_PLATFORM){
"win-64"{copy-item $ROOT/temp/$name/$name/build/$name.exe $env:PREFIX/bin/$name.exe}
"linux-64"{copy-item $ROOT/temp/$name/$name/build/$name $env:PREFIX/bin/$name}
"linux-aarch64"{copy-item $ROOT/temp/$name/$name/build/$name $env:PREFIX/bin/$name}
}
