#!/usr/local/bin/pwsh
param (
    [string]$XVM_VERSION = "",
    [switch]$DEV_XVM
)

if ($DEV_XVM) {
    $XVM_VERSION = "DEV"
}
else {
    if ($XVM_VERSION) {
        Write-Output "Trying to work with XVM $XVM_VERSION..."
    }
    else {
        $XVM_VERSION = $(Invoke-WebRequest -uri http://nightly.modxvm.com/download/default/xvm_version.txt -usebasic).content.Trim()
        $answer = Read-Host "No XVM version specified (via -x). Try with the latest ($XVM_VERSION) (yes/no)"
        if (!$answer.Trim().ToLower().StartsWith("y")) {
            $XVM_VERSION = ""
            Write-Host "All done, then."
        }
    }
}

if ($XVM_VERSION) {
    if ($DEV_XVM) {
        $XVM_RELEASE = "latest_xvm.zip"
        $XVM_URL = "http://nightly.modxvm.com/download/default/$XVM_RELEASE"
    }
    else {
        $XVM_RELEASE = "xvm-$XVM_VERSION.zip"
        $XVM_URL = "https://dl1.modxvm.com/bin/$XVM_RELEASE"
    }
    if (test-path "latest") {
        Remove-Item -recurse -force latest
    }
    Write-Output "Downloading '$XVM_RELEASE'..."
    Invoke-WebRequest -uri $XVM_URL -out "$XVM_RELEASE"
    Write-Output "Extracting..."
    Expand-Archive "$XVM_RELEASE" -DestinationPath latest
    Write-Output "Clearing old PYC-files..."
    Get-ChildItem -Path "$($global:PSScriptRoot)/../.." -Filter *.pyc -Recurse | ForEach-Object ($_) {Remove-Item $_.FullName}
    Remove-Item "$($global:PSScriptRoot)/../mods" -Recurse -Force
    Copy-Item -Recurse "$($global:PSScriptRoot)/latest/res_mods/mods" "$($global:PSScriptRoot)/../mods"
    Write-Output "Launch Beyond Compare..."
    Write-Output "REMEMBER TO REPLACE py_macro WITH THE ONE FROM latest!!!"
    bcomp . ./latest/res_mods/configs
    Write-Output "Done."
}