#!/usr/local/bin/pwsh
param (
    [switch]$verbose
)
$scriptDir = $(Split-Path $MyInvocation.MyCommand.Path)
if ($verbose) {
    Write-Output "[scriptDir = $scriptDir]"
}
Set-Location $scriptDir
$currentLocation = Get-Location
if ($verbose) {
    Write-Output "Current location: $currentLocation"
}

$prefix = "Does not exist:"

if (Test-Path ".\latest\res_mods\configs\xvm\py_macro") {
    Remove-Item -Recurse -Force ".\xvm\py_macro"
    Copy-Item -Recurse ".\latest\res_mods\configs\xvm\py_macro" ".\xvm\"
    Write-Output "Processed 'py_macro'."
} else {
    Write-Output "$prefix .\latest\res_mods\configs\xvm\py_macro"
}

Copy-Item "resources\sixthsense.png" ".\..\mods\shared_resources\xvm\res\sixthsense.png"
Write-Output "Copied the sixth sense -image."

if (Test-Path ".\latest\mods") {
    Remove-Item -Recurse -Force ".\..\..\mods"
    Copy-Item -Recurse ".\latest\mods" ".\..\.."
    Write-Output "Processed 'mods'."
} else {
    Write-Output "$prefix $scriptDir\latest\mods"
}