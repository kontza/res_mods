#!/usr/local/bin/pwsh
<#
.SYNOPSIS
    This script is tool to help in updating your XVM config to be compatible with the latest XVM version.

.DESCRIPTION
    The script downloads a version of the XVM, the runs Beyond Compare (tm) against your
    own config vs the downloaded XVM's config. Once comparison is done, it will replace
    the XVM with the downloaded one, along installing your custom sixth sense icon
    from the resources folder.

    Beyond Compare, by Scooter Software, is the world's best diff-tool.

.PARAMETER XVM_VERSION
    Specify the version of XVM to download. Use 'dev' as the version
    to instruct the script to download the development version
    of the XVM.
.PARAMETER BCompare
    Launch the Beyond Compare (tm) stage (default = false).
.PARAMETER sixthsense
    Only install the sixth sense icon.
.PARAMETER finalize
    Only run the finalize step, i.e. replace the old XVM with the
    new downloaded one, and copy the sixth sense icon.
.EXAMPLE
    .\install.ps1 -x 8.0.0 -b
    Download the 8.0.0 version of the XVM, print out verbosely
    what is being done, and run the Beyond Compare (tm) step.
.NOTES
    Author: Juha Ruotsalainen
#>
param (
    [string]$XVM_VERSION = "8.7.2",
    [switch]$BCompare = $false,
    [switch]$sixthSense,
    [switch]$finalize
)
$VerbosePreference = "Continue"
$scriptDir = $(Split-Path $MyInvocation.MyCommand.Path)
Set-Location $scriptDir
Write-Verbose "scriptDir = $scriptDir"

function Install6thSenseIcon {
    Copy-Item -Verbose ".\resources\sixthsense.png" ".\..\mods\shared_resources\xvm\res\sixthsense.png"
}

function Main {
    Write-Verbose "Running 'git pull'..."
    git pull
    $XVM_VERSION = $XVM_VERSION.ToUpper()
    if ($XVM_VERSION) {
        Write-Verbose "Trying to work with XVM $XVM_VERSION..."
    }
    else {
        $XVM_VERSION = $(Invoke-WebRequest -uri http://nightly.modxvm.com/download/default/xvm_version.txt -usebasic).content.Trim()
        $answer = Read-Host "No XVM version specified (via -x). Try with the latest ($XVM_VERSION) (yes/no)"
        if (!$answer.Trim().ToLower().StartsWith("y")) {
            $XVM_VERSION = ""
            Write-Verbose "All done, then."
            return
        }
    }

    if ($XVM_VERSION.StartsWith("DEV")) {
        $XVM_RELEASE = "xvm_latest.zip"
        $XVM_URL = "https://nightly.modxvm.com/download/master/$XVM_RELEASE"
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
    }
    else {
        $answer = "yes"
    }
    if ($answer.Trim().ToLower().StartsWith("y")) {
        Write-Verbose "Downloading '$XVM_URL'..."
        try {
            Invoke-WebRequest -uri $XVM_URL -out "$XVM_RELEASE"
        } catch {
            $statusCode = $_.Exception.Response.StatusCode.Value__
            Write-Verbose "Failed due to HTTP $statusCode"
            return
        }
    }
    if (Test-Path $XVM_RELEASE) {
        Write-Verbose "Extracting..."
        Expand-Archive "$XVM_RELEASE" -Verbose:$false -DestinationPath latest
        Write-Verbose "Clearing old PYC-files..."
        Get-ChildItem -Path ".\..\.." -Filter *.pyc -Recurse | ForEach-Object ($_) { Remove-Item $_.FullName }
        if ($BCompare) {
            Write-Verbose "Launch Beyond Compare..."
            bcomp . ./latest/res_mods/configs
        }
        else {
            Write-Verbose "Bypassing Beyond Compare."
        }
        Write-Verbose "Done."
    }
    else {
        Write-Verbose "Download failed."
        return
    }
    return "OK"
}

function Finalize {
    $prefix = "Does not exist:"

    if (Test-Path ".\latest\res_mods\configs\xvm\py_macro") {
        Remove-Item -Recurse -Force ".\xvm\py_macro"
        Copy-Item -Recurse ".\latest\res_mods\configs\xvm\py_macro" ".\xvm\"
        Write-Verbose "Processed 'py_macro'."
    }
    else {
        Write-Verbose "$prefix .\latest\res_mods\configs\xvm\py_macro"
    }

    if (Test-Path ".\latest\mods") {
        Remove-Item -Recurse -Force ".\..\..\mods"
        Copy-Item -Recurse ".\latest\mods" ".\..\.."
        Write-Verbose "Processed 'mods'."
    }
    else {
        Write-Verbose "$prefix $scriptDir\latest\mods"
    }

    if (Test-Path ".\latest\res_mods\mods") {
        Remove-Item -Recurse -Force ".\..\mods"
        Copy-Item -Recurse ".\latest\res_mods\mods" ".\.."
        Write-Verbose "Processed 'res_mods\mods'."
    }
    else {
        Write-Verbose "$prefix $scriptDir\latest\res_mods\mods"
    }
}

if ($sixthSense) {
    Install6thSenseIcon
}
elseif ($finalize) {
    Finalize
}
else {
    $result = Main
    if ($result) {
        Finalize
        Install6thSenseIcon
    }
}
Write-Verbose "All done, TTFN."
