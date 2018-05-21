param(
    [string]$XVM_VERSION = $(iwr -uri http://nightly.modxvm.com/download/default/xvm_version.txt -usebasic).content.trim()
)
$XVM_RELEASE = "xvm-$XVM_VERSION.zip"
if (test-path "latest") {
    rm -recurse -force latest
}
echo "Downloading '$XVM_RELEASE'..."
iwr -uri "https://dl1.modxvm.com/bin/$XVM_RELEASE" -out "$XVM_RELEASE"
echo "Extracting..."
Expand-Archive "$XVM_RELEASE" -DestinationPath latest
echo "Clearing old PYC-files..."
pushd ..\..
get-childitem . -include *.pyc -recurse | foreach ($_) {remove-item $_.fullname}
popd
echo "Launch Beyond Compare..."
bcomp bcomp . .\latest\res_mods\configs
echo "Done."
