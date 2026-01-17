set-location $PSScriptRoot
gh release download -R "Loyalsoldier/v2ray-rules-dat" -p "geoip.dat" `
    -O  $PSScriptRoot/geoip.dat
gh release download -R "Loyalsoldier/v2ray-rules-dat" -p "geosite.dat" `
    -O  $PSScriptRoot/geosite.dat
