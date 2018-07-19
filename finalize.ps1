#!/usr/local/bin/pwsh
param (
    [switch]$verbose
)
$scriptDir = $(Split-Path $MyInvocation.MyCommand.Path)
if ($verbose) {
    Write-Output "[scriptDir = $scriptDir]"
}

$prefix = "Does not exist:"

if (Test-Path $scriptDir/latest/res_mods/configs/xvm/py_macro) {
    Remove-Item -r "$scriptDir/xvm/py_macro"
    Move-Item "$scriptDir/latest/res_mods/configs/xvm/py_macro" "$scriptDir/xvm/"
    Write-Output "Processed 'py_macro'."
} else {
    Write-Output "$prefix $scriptDir/latest/res_mods/configs/xvm/py_macro"
}

Copy-Item resources/sixthsense.png "$scriptDir/../mods/shared_resources/xvm/res/sixthsense.png"
Write-Output "Copied the sixth sense -image."

if (Test-Path $scriptDir/latest/mods) {
    Remove-Item -r "$scriptDir/../../mods"
    Move-Item "$scriptDir/latest/mods" "$scriptDir/../.."
    Write-Output "Processed 'mods'."
} else {
    Write-Output "$prefix $scriptDir/latest/mods"
}