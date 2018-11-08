#!/bin/bash
set -e  # exit on first error
CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
UBUNTU_CODENAME=$(lsb_release -sc)


main()
{
    install_dependencies
    install_libQtSSR 
    install_qt5gui
}

install_dependencies() 
{
    sudo apt -y install libqrencode-dev libzbar-dev libappindicator1
}

install_botan2()
{
    echo "Installing botan ..........."
    cd /tmp 
    rm -rf botan 
    git clone --depth 1 --single-branch -b 2.8.0 https://github.com/randombit/botan.git
    cd botan 
    ./configure.py --prefix=/usr/local --without-documentation
    make -j$(nproc)
    sudo make install 
    cd ..
    rm -rf botan
}

install_libQtSSR() 
{
    install_botan2
    echo "Installing libQtShadowsocks......."
    cd /tmp 
    rm -rf libQtShadowsocks
    git clone --depth 1 --single-branch -b v2.1.0  https://github.com/shadowsocks/libQtShadowsocks.git
    cd libQtShadowsocks
    mkdir -p build && cd build
    cmake .. -DCMAKE_INSTALL_PREFIX=/usr -DUSE_BOTAN2=ON
    make -j$(nproc)
    sudo make install
    cd .. && rm -rf libQtShadowsocks
    echo "libQtShadowsocks installed."

}

install_qt5gui()
{
    echo "Installing Qt5Gui for SSR......"
    cd /tmp 
    rm -rf shadowsocks-qt5 
    git clone --depth 1 --single-branch -b v3.0.1 https://github.com/shadowsocks/shadowsocks-qt5.git
    cd shadowsocks-qt5 
    mkdir -p build && cd build
    cmake .. -DCMAKE_INSTALL_PREFIX=/usr
    make -j$(nproc)
    sudo make install
    echo "Qt5Gui installed for SSR."
}


main
