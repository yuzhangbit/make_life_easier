#!/bin/bash
set -e  # exit on first error
CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
UBUNTU_CODENAME=$(lsb_release -sc)
CATKIN_WS_DIR="$HOME/catkin_ws"
ROS_DISTRO="kinetic"

main()
{

  echo ${UBUNTU_CODENAME}
  ros_install
  create_catkin_ws
}

ros_install()
{
  if [ "${UBUNTU_CODENAME}" == "xenial" ]; then
    echo "Installing ros kinetic.........."
    sudo sh -c '. /etc/lsb-release && echo "deb https://mirror.tuna.tsinghua.edu.cn/ros/ubuntu/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
    sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116
    echo "Updating package lists ..."
    #sudo apt-get -qq update
    echo "Installing ROS $ROS_DISTRO ..."
    sudo apt-get update
    sudo apt-get -y install ros-$ROS_DISTRO-desktop
    sudo apt-get -qq install python-catkin-tools
    sudo apt-get -qq install ros-$ROS_DISTRO-catkin

    # check if the ros setup file is sourced.
    if (grep 'source /opt/ros/kinetic/setup.bash' $HOME/.bashrc); then
      echo "The ros setup.bash has been sourced."
    else
      echo "source /opt/ros/kinetic/setup.bash" >> ~/.bashrc
    fi
    source /opt/ros/$ROS_DISTRO/setup.bash

    sudo apt-get -qq install python-rosinstall
  else
    echo "This is a script only for ubuntu 16.04."
  fi
}


create_catkin_ws()
{
    # Check if workspace exists
    if [ -e "$CATKIN_WS_DIR/.catkin_workspace" ] || [ -d "$CATKIN_WS_DIR/.catkin_tools" ]; then
        echo "Catkin workspace detected at ~/catkin_ws"
        rm -rf build devel install logs
    else
        echo "Creating catkin workspace in $HOME/catkin_ws ..."
        source /opt/ros/$ROS_DISTRO/setup.bash
        mkdir -p "$CATKIN_WS_DIR/src"
        cd "$CATKIN_WS_DIR"
        catkin init
        cd "$CATKIN_WS_DIR"
        catkin build
        echo "Catkin workspace created successfully."
    fi
    # check if the ros setup file is sourced.

    if (grep 'source ~/catkin_ws/devel/setup.bash' $HOME/.bashrc); then
      source $HOME/.bashrc
      echo "The ros catkin_ws/devel/setup.bash has been sourced."
    else
      echo "source ~/catkin_ws/devel/setup.bash" >> ~/.bashrc
      source $HOME/.bashrc
    fi
}

main
