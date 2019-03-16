#!/bin/bash
set -e  # exit on first error
CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

main(){
  install_buildtool
}

install_buildtool(){
  sudo apt-get install -y python3-pip
  sudo pip3 install --upgrade pip wheel setuptools
}


main
