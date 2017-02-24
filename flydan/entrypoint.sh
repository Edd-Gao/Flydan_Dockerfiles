#!/bin/bash
set -e

# setup ros environment
source "/opt/ros/$ROS_DISTRO/setup.bash"
source "/root/catkin_ws/devel/setup.bash"
source /root/Firmware/Tools/setup_gazebo.bash /root/Firmware /root/Firmware/build_posix_sitl_default
export GAZEBO_MODEL_PATH=$GAZEBO_MODEL_PATH:~/models
export ROS_PACKAGE_PATH=$ROS_PACKAGE_PATH:/root/Firmware

exec "$@"
