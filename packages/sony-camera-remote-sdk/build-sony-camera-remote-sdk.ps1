$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

$archUrls = @{
    "Windows" = "win"
    "MacOS"  = "mac"
    "Linux"  = "linux_x86"
    "MacArm64" = "linux_64"
}

$archKey = if ($IsWindows) { "Windows" }
           elseif ($IsMacOS -and $arch -eq "Arm64") { "MacArm64" }
           elseif ($IsMacOS) { "MacOS" }
           elseif ($IsLinux -and $arch -eq "X64") { "Linux" }

$downloadUrl = "https://support.d-imaging.sony.co.jp/disoft_DL/SDK_DL/$($archUrls[$archKey])?fm=en-us"
aria2c -c -x16 -s16 $downloadUrl -o "${env:PKG_NAME}.zip"

7z x "${env:PKG_NAME}.zip" "-osdk"

New-Item "$env:PREFIX/${env:PKG_NAME}" -ItemType Directory
Copy-Item "./sdk/*" "$env:PREFIX/${env:PKG_NAME}" -Recurse

# Cleanup
Remove-Item "$env:PREFIX/${env:PKG_NAME}/app/*.h", "$env:PREFIX/${env:PKG_NAME}/app/*.cpp", "$env:PREFIX/${env:PKG_NAME}/*.zip"
Remove-Item "$env:PREFIX/${env:PKG_NAME}/external/opencv/" -Recurse
