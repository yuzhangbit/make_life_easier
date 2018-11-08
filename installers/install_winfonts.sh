#!/bin/bash
set -e  # exit on first error

install_winfonts()
{
   cd /tmp
   if [ ! -d winfonts ]; then
     echo "It is downloading the windows fonts. This will take a while......"
     git clone --depth 1 --branch master https://git.coding.net/aRagdoll/winfonts.git
   else
     echo "Fonts exists in /tmp/winfonts........"
     cd winfonts && git reset --hard && git checkout master && git pull
   fi
   bash /tmp/winfonts/install_fonts.sh
   echo "Windows fonts have been installed successfully."
}

install_winfonts
