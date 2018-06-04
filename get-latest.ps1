param(
    [string]$XVM_VERSION = ""
)

if($XVM_VERSION) {
    Write-Output "Trying to work with XVM $XVM_VERSION..."
} else {
    $answer = Read-Host 'No XVM version specified (via -x). Try with the latest (yes/no)'
    if ($answer.Trim().ToLower().StartsWith("y")) {
        $XVM_VERSION = $(Invoke-WebRequest -uri http://nightly.modxvm.com/download/default/xvm_version.txt -usebasic).content.Trim()
    } else {
        Write-Output "Aborting, cannot continue."
    }
}

if($XVM_VERSION) {
    $XVM_RELEASE = "xvm-$XVM_VERSION.zip"
    if (test-path "latest") {
        Remove-Item -recurse -force latest
    }
    Write-Output "Downloading '$XVM_RELEASE'..."
    Invoke-WebRequest -uri "https://dl1.modxvm.com/bin/$XVM_RELEASE" -out "$XVM_RELEASE"
    Write-Output "Extracting..."
    Expand-Archive "$XVM_RELEASE" -DestinationPath latest
    Write-Output "Clearing old PYC-files..."
    Push-Location ..\..
    get-childitem . -include *.pyc -recurse | foreach ($_) {remove-item $_.fullname}
    Pop-Location
    Write-Output "Launch Beyond Compare..."
    bcomp . .\latest\res_mods\configs
    Write-Output "Done."
}