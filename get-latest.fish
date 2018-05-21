set -g XVM_VERSION (curl -s http://nightly.modxvm.com/download/default/xvm_version.txt|head -1)
set -g XVM_RELEASE "xvm-$XVM_VERSION.zip"
rm -rf latest
echo "Downloading '$XVM_RELEASE'..."
wget -q https://dl1.modxvm.com/bin/$XVM_RELEASE -O $XVM_RELEASE
echo "Extracting..."
unzip -q $XVM_RELEASE -d latest
echo "Done."
find ../.. -name '*.pyc' -delete
bcomp "WoT configs"
