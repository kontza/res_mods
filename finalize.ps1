#!/usr/local/bin/pwsh
$scriptDir = $(Split-Path $MyInvocation.MyCommand.Path)
Remove-Item -r "$scriptDir/xvm/py_macro"
Move-Item "$scriptDir/latest/res_mods/configs/xvm/py_macro" "$scriptDir/xvm/"
Copy-Item -v resources/sixthsense.png "$scriptDir/../mods/shared_resources/xvm/res/sixthsense.png"
Remove-Item -r "$scriptDir/../../mods"
Move-Item "$scriptDir/latest/mods" "$scriptDir/../.."