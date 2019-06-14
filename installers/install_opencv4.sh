#!/bin/bash
set -e  # exit on first error
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

main(){
  install_opencv4
}



install_opencv4(){
  cd /tmp && rm -rf opencv
  git clone --depth 1 https://github.com/opencv/opencv.git
  cd opencv && mkdir -p build && cd build
  cmake -D CMAKE_BUILD_TYPE=Release -D CMAKE_INSTALL_PREFIX=/usr/local ..
  make -j$(nproc)
}

main
