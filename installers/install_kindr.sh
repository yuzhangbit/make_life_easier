#!/bin/bash
set -e  # exit on first error

main(){
  cd /tmp && rm -rf kindr && git clone --depth 1 --branch 1.1.2 https://github.com/ANYbotics/kindr.git
  cd kindr
  mkdir -p build && cd build && cmake ..
  make -j4
  sudo make install
}

main
