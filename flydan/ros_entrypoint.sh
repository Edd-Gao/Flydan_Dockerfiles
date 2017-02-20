#!/bin/bash
set -e

# setup ros environment
source "/opt/ros/$ROS_DISTRO/setup.bash"
source "/catkin_ws/devel/setup.bash"
/Firmware/integrationtests/setup_gazebo_ros.bash /Firmware

exec "$@"