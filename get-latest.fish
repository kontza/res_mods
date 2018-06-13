#!/usr/local/bin/fish
function doit
    set -l x_found ""
    set -l XVM_VERSION ""
    for option in $argv
        if test "$x_found" = "x"
            set XVM_VERSION $option
            break
        end
        switch "$option"
            case -x --xvm-version
                set x_found "x"
        end
    end
    if test -z "$XVM_VERSION"
        read -P 'No XVM version defined. Try with the latest (y/n) ? ' answer
        switch $answer
            case "y*" "Y*"
                set XVM_VERSION (curl -s http://nightly.modxvm.com/download/default/xvm_version.txt|head -1)
            case "*"
                echo "Cannot continue."
        end
    end
    if test -n "$XVM_VERSION"
        set XVM_RELEASE "xvm-$XVM_VERSION.zip"
        rm -rf latest
        echo "Downloading '$XVM_RELEASE'..."
        wget -q https://dl1.modxvm.com/bin/$XVM_RELEASE -O $XVM_RELEASE
        echo "Extracting..."
        unzip -q $XVM_RELEASE -d latest
        find ../.. -name '*.pyc' -delete
        rm -rf ../mods
        mv latest/res_mods/mods ..
        bcomp "WoT configs"
        echo "Done."
    end
    set XVM_VERSION ""
    set x_found ""
end
doit $argv
