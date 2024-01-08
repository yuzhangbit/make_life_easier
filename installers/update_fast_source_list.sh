#!/bin/bash
set -e  # exit on first error
UBUNTU_CODENAME=$(lsb_release -sc)

#URL="https://mirrors.huaweicloud.com/ubuntu/"

# tuna is faster than huaweiyun 

URL="https://mirrors.tuna.tsinghua.edu.cn/ubuntu/"

main()
{
   sudo apt install -y lsb-core
   lsb_release -a
   update_sourceslist
}


update_sourceslist()
{
   cd /etc/apt
   sudo mv sources.list sources.list.bak
   sudo touch sources.list
   echo "deb $URL $UBUNTU_CODENAME main restricted universe multiverse" | sudo tee -a sources.list >  /dev/null
   echo "deb $URL $UBUNTU_CODENAME-updates main restricted universe multiverse" | sudo tee -a sources.list >  /dev/null
   echo "deb $URL $UBUNTU_CODENAME-security main restricted universe multiverse" | sudo tee -a sources.list >  /dev/null
   echo "deb $URL $UBUNTU_CODENAME-backports main restricted universe multiverse" | sudo tee -a sources.list >  /dev/null
   echo "deb $URL $UBUNTU_CODENAME-proposed main restricted universe multiverse" | sudo tee -a sources.list >  /dev/null

   # source will affect the update speed
   #echo "deb-src $URL $UBUNTU_CODENAME main restricted universe multiverse" | sudo tee -a sources.list >  /dev/null
   #echo "deb-src $URL $UBUNTU_CODENAME-updates main restricted universe multiverse" | sudo tee -a sources.list >  /dev/null
   #echo "deb-src $URL $UBUNTU_CODENAME-security main restricted universe multiverse" | sudo tee -a sources.list >  /dev/null
   #echo "deb-src $URL $UBUNTU_CODENAME-backports main restricted universe multiverse" | sudo tee -a sources.list >  /dev/null
   #echo "deb-src $URL $UBUNTU_CODENAME-proposed main restricted universe multiverse" | sudo tee -a sources.list >  /dev/null

   sudo apt-get update
}

main
