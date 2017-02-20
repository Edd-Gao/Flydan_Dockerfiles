#!/bin/bash
set -e

# setup ros environment
source "/opt/ros/$ROS_DISTRO/setup.bash"
source "/root/catkin_ws/devel/setup.bash"
source /root/Firmware/integrationtests/setup_gazebo_ros.bash /Firmware
export GAZEBO_MODEL_PATH=$GAZEBO_MODEL_PATH:~/models

exec "$@"