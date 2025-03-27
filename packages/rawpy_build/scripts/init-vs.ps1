
# https://wiki.python.org/moin/WindowsCompilers
# setuptools automatically selects the right compiler for building
# the extension module. The following is mostly for building any
# native dependencies, here via CMake.
# https://docs.microsoft.com/en-us/cpp/build/building-on-the-command-line
# https://docs.microsoft.com/en-us/cpp/porting/binary-compat-2015-2017

$VS_ROOT = "C:\Program Files\Microsoft Visual Studio"
$VS_VERSIONS = @("2022")
$VS_EDITIONS = @("Enterprise", "Professional", "Community")
$VS_INIT_CMD_SUFFIX = "Common7\Tools\VsDevCmd.bat"

$VS_ARCH = if ($env:PYTHON_ARCH -eq 'x86') { 'x86' } else { 'x64' }
$VS_INIT_ARGS = "-arch=$VS_ARCH -no_logo"

$found = $false
:outer foreach ($version in $VS_VERSIONS) {
    foreach ($edition in $VS_EDITIONS) {
        $VS_INIT_CMD = "$VS_ROOT\$version\$edition\$VS_INIT_CMD_SUFFIX"
        Write-Output $VS_INIT_CMD
        if (Test-Path $VS_INIT_CMD) {
            $found = $true
            break outer
        }
    }
}

if (!$found) {
    throw ("No suitable Visual Studio installation found")
}

Write-Host "Executing: $VS_INIT_CMD $VS_INIT_ARGS"

# https://github.com/Microsoft/vswhere/wiki/Start-Developer-Command-Prompt
& "${env:COMSPEC}" /s /c "`"$VS_INIT_CMD`" $VS_INIT_ARGS && set" | foreach-object {
    $name, $value = $_ -split '=', 2
    try {
        set-content env:\"$name" $value
    }
    catch {
    }
}
