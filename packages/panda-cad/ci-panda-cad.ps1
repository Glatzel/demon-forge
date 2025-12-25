Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
$latest_version = get-version-url -url "https://www.intrsio.com/producterDownload/producterDownloadIndex.do" -pattern '版本：(\d+\.\d+\.\d+\.\d+)'
update-recipe -version $latest_version

aria2c -c -x16 -s16 -d "$ROOT/temp/$name/" `
    https://www.intrsio.com/downloadFile.jsp?fileName=PandaCAD-x64-v${latest_version}-Setup.exe `
    -o "$name.exe"
7z x "$ROOT/temp/$name/$name.exe" "-o$ROOT/temp/$name/$name/"
build-pkg
