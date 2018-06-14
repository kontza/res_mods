#!/usr/local/bin/pwsh
$scriptDir = $(Split-Path $MyInvocation.MyCommand.Path)
Copy-Item -v resources/sixthsense.png "$scriptDir/../mods/shared_resources/xvm/res/sixthsense.png"
