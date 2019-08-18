#!/usr/local/bin/pwsh
<#
.SYNOPSIS
    This script is tool to help in updating your XVM config to be compatible with the latest XVM version.

.DESCRIPTION
    The script downloads a version of the XVM, the runs Beyond Compare (tm) against your
    own config vs the downloaded XVM's config. Once comparison is done, it will replace
    the XVM with the downloaded one, along installing your custom sixth sense icon
    from the resources folder.

.PARAMETER XVM_VERSION
    Specify the version of XVM to download.
.PARAMETER DEVXVM
    Instruct the script to download a development version of the XVM.
.PARAMETER noBCompare
    Skip the Beyond Compare (tm) stage.
.PARAMETER verbose
    Print out more information about what is being done.
.EXAMPLE
    C:\PS> 
    <Description of example>
.NOTES
    Author: Juha Ruotsalainen
#>
param (
    [string]$XVM_VERSION = "",
    [switch]$DEV_XVM,
    [switch]$noBCompare,
    [switch]$verbose,
    [switch]$sixthSense
)
$scriptDir = $(Split-Path $MyInvocation.MyCommand.Path)

function Install6thSenseIcon {
    Set-Location $scriptDir
    Copy-Item -Verbose ".\resources\sixthsense.png" ".\..\mods\shared_resources\xvm\res\sixthsense.png"
}

if ($DEV_XVM) {
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
        $XVM_URL = "http://dl1.modxvm.com/get/bin/$XVM_RELEASE"
    }
    if (Test-Path "latest") {
        Remove-Item -recurse -force latest
    }
    if (Test-Path $XVM_RELEASE) {
        $answer = Read-Host "$XVM_RELEASE already exists. Download again? (yes/no)"
    } else {
        $answer = "yes"
    }
    if ($answer.Trim().ToLower().StartsWith("y")) {
        if ($verbose) {
            Write-Output "Downloading '$XVM_URL'..."
        }
        else {
            Write-Output "Downloading '$XVM_RELEASE'..."
        }
        Invoke-WebRequest -uri $XVM_URL -out "$XVM_RELEASE"
    }
    if (Test-Path $XVM_RELEASE) {
        Write-Output "Extracting..."
        Expand-Archive "$XVM_RELEASE" -DestinationPath latest
        Write-Output "Clearing old PYC-files..."
        $scriptDir = $(Split-Path $MyInvocation.MyCommand.Path)
        Set-Location $scriptDir
        if ($verbose) {
            Write-Output "[scriptDir = $scriptDir]"
        }
        Get-ChildItem -Path ".\..\.." -Filter *.pyc -Recurse | ForEach-Object ($_) {Remove-Item $_.FullName}
        if ($noBCompare) {
            Write-Output "Bypassing Beyond Compare."
        }
        else {
            Write-Output "Launch Beyond Compare..."
            bcomp . ./latest/res_mods/configs
        }
        Write-Output "Done."
    }
    else {
        Write-Output "Download failed."
    }
}