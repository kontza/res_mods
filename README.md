# Introduction
My WoT res_mods (based on QB's modpack + JustForLolzFYI's icon as the 6th sense icon)

# Preparation
These steps need to be run only on a fresh game install:
1. Install Git so that you can run `git` in PowerShell.
1. Open PowerShell and `cd` into the game's directory.
1. Go into `res_mods` directory under the game's directory:
    ```bash
    $ cd res_mods
    ```
1. If there is a `configs` directory, remove it:
    ```bash
    $ rm -f configs
    ```
1. Clone this repository:
    ```bash
    $ git clone https://github.com/kontza/res_mods__configs.git configs
    ```

# Installation/Update
1. Open PowerShell and `cd` into the game's directory.
1. Go into `res_mods/configs` directory under the game's directory:
1. Check from http://modxvm.com/en/download-xvm/ if there is a version for your game version. If there is, take note of the XVM version.
1. Run the install script:
    ```bash
    $ ./install.ps1 [-x X.Y.Z] [-b]
    # Or
    $ ./install.ps1 [-x dev] [-b]
    ```
    The `-b` option tries to launch Beyond Compare while installing so that you can check if your and XVM team's configs differ. The `-x` option is used to specify which version of XVM download. The special version _dev_ will download a nightly version of XVM.