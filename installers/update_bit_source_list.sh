#!/bin/bash
set -e  # exit on first error
UBUNTU_CODENAME=$(lsb_release -sc)


main()
{
   if [ "${UBUNTU_CODENAME}" == "xenial" ]; then
      echo "Updating to BIT's sources list.........."
      update_sourceslist
      echo "Done!"
   else
      echo "This is a script only for ubuntu 16.04."
   fi

}


update_sourceslist()
{
cd /etc/apt
sudo mv sources.list sources.list.bak
sudo touch sources.list
sudo sh -c 'echo "deb http://mirror.bit.edu.cn/ubuntu/ xenial main restricted universe multiverse
deb http://mirror.bit.edu.cn/ubuntu/ xenial-security main restricted universe multiverse
deb http://mirror.bit.edu.cn/ubuntu/ xenial-updates main restricted universe multiverse
deb http://mirror.bit.edu.cn/ubuntu/ xenial-backports main restricted universe multiverse
##测试版源
deb http://mirror.bit.edu.cn/ubuntu/ xenial-proposed main restricted universe multiverse
# 源码
deb-src http://mirror.bit.edu.cn/ubuntu/ xenial main restricted universe multiverse
deb-src http://mirror.bit.edu.cn/ubuntu/ xenial-security main restricted universe multiverse
deb-src http://mirror.bit.edu.cn/ubuntu/ xenial-updates main restricted universe multiverse
deb-src http://mirror.bit.edu.cn/ubuntu/ xenial-backports main restricted universe multiverse
##测试版源
deb-src http://mirror.bit.edu.cn/ubuntu/ xenial-proposed main restricted universe multiverse" >> sources.list'
sudo apt-get update
}

main
