#!/bin/bash
set -e  # exit on first error
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DIR=/tmp

main(){
    sudo apt-get update && sudo apt-get -y install git cmake build-essential gcc g++
    install_benchmark
}


install_benchmark(){
    cd $DIR && rm -rf benchmark
    git clone https://github.com/google/benchmark.git
    cd benchmark && git clone https://github.com/google/googletest.git
    mkdir build && cd build
    cmake .. -DCMAKE_BUILD_TYPE=RELEASE
    make -j$(nproc)
    sudo make install
}

main
