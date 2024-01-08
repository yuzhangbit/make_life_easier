#!/bin/bash
set -e  # exit on first error

sudo apt install 2to3

cd /tmp
rm -rf mendeleydesktop_1.19.8_for_ubuntu_22.04.deb
sudo apt install -y gconf2
sudo apt --fix-broken install -y
axel -a -n 32 https://github.com/JezaChen/MendeleyDesktop-For-Ubuntu-22.04/releases/download/Packaged/mendeleydesktop_1.19.8_for_ubuntu_22.04.deb
sudo dpkg -i mendeleydesktop_1.19.8_for_ubuntu_22.04.deb

