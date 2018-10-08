#!/bin/bash
set -e  # exit on first error
CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
UBUNTU_CODENAME=$(lsb_release -sc)
ROS2_VERSION="bouncy"


# install libasio-dev for ament build, need to verify using


main()
{
 #set_utf8_locale
 #set_ros2_apt_repo
 #install_dev_tools
 #create_ws_and_source_codes
 install_dependencies
}


set_utf8_locale()
{
 sudo locale-gen en_US en_US.UTF-8
 sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
 export LANG=en_US.UTF-8
}

set_ros2_apt_repo()
{
 echo "Setting the apt soures......."
 sudo apt update && sudo apt install curl
 curl http://repo.ros2.org/repos.key | sudo apt-key add -
 # add repository to your source list
 sudo sh -c 'echo "deb [arch=amd64,arm64] http://repo.ros2.org/ubuntu/main `lsb_release -cs` main" > /etc/apt/sources.list.d/ros2-latest.list'
 # export the ros version
 export ROS_DISTRO=bouncy
 sudo apt update
}

install_dev_tools()
{
  echo "Installing development tools and ROS tools....."
  sudo apt update && sudo apt install -y \
   build-essential \
   cmake \
   git \
   python3-colcon-common-extensions \
   python3-pip \
   python-rosdep \
   python3-vcstool \
   wget

  # install some pip packages needed for testing
  sudo -H python3 -m pip install -U \
   argcomplete \
   flake8 \
   flake8-blind-except \
   flake8-builtins \
   flake8-class-newline \
   flake8-comprehensions \
   flake8-deprecated \
   flake8-docstrings \
   flake8-import-order \
   flake8-quotes \
   pytest-repeat \
   pytest-rerunfailures
   # [Ubuntu 16.04] install extra packages not available or recent enough on Xenial
   python3 -m pip install -U \
    pytest \
    pytest-cov \
    pytest-runner \
    setuptools
   # install Fast-RTPS dependencies
   sudo apt install --no-install-recommends -y \
    libasio-dev \
    libtinyxml2-dev
}


create_ws_and_source_codes()
{
 echo "Create ROS2 workspace and get the source codes......."
 mkdir -p ~/ros2_ws/src
 cd ~/ros2_ws
 wget https://raw.githubusercontent.com/ros2/ros2/release-latest/ros2.repos
 vcs import src < ros2.repos
}

install_dependencies()
{
 echo "Installing ROS dependencies....."
 #sudo rosdep init
 rosdep update
 rosdep install --from-paths src --ignore-src --rosdistro bouncy -y --skip-keys "console_bridge fastcdr fastrtps libopensplice67 rti-connext-dds-5.3.1 urdfdom_headers"
}


 main
