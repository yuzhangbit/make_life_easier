#!/bin/bash
set -e # exit on the first error
PROFILER_VERSION="v2.0.1"
BENCHMARK_VERSION="release-1.8.1"

main(){
  sudo apt-get -y install qtbase5-dev  # for cmake to find qt5widgets
  install_easy_profiler
  install_benchmark
}

install_easy_profiler(){
  cd /tmp && rm -rf easy_profiler
  git clone --branch ${PROFILER_VERSION} --depth 1 https://github.com/yse/easy_profiler.git
  cd easy_profiler
  mkdir -p build && cd build
  cmake -DCMAKE_BUILD_TYPE="Release" -DCMAKE_PREFIX_PATH=/usr/lib/x86_64-linux-gnu ..
  make -j$(nproc)
  sudo make install
}

install_benchmark(){
    cd /tmp && rm -rf benchmark
    git clone --depth 1 https://github.com/google/benchmark.git
    cd benchmark && git clone --branch ${BENCHMARK_VERSION} --depth 1 https://github.com/google/googletest.git
    mkdir build && cd build
    cmake .. -DCMAKE_BUILD_TYPE=RELEASE
    make -j$(nproc)
    sudo make install
}

main
