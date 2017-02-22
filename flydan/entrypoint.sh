#!/bin/bash
set -e

# setup ros environment
source "/opt/ros/$ROS_DISTRO/setup.bash"
source "/root/catkin_ws/devel/setup.bash"
source /root/Firmware/Tools/setup_gazebo.bash /root/Firmware /root/Firmware
export GAZEBO_MODEL_PATH=$GAZEBO_MODEL_PATH:~/models

exec "$@"
