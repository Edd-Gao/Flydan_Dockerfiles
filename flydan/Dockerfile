FROM ros:indigo-ros-base

#update the source list
RUN apt-get update; exit 0

#install https transport util for apt
RUN apt-get install apt-transport-https -y

#substitute the original mirror with tsinghua tuna mirror
RUN sh -c '. /etc/lsb-release && echo "deb https://mirrors.tuna.tsinghua.edu.cn/ros/ubuntu/ $DISTRIB_CODENAME main" > /etc/apt/sources.list.d/ros-latest.list'
ADD ./sources.list /etc/apt/sources.list

#update apt-get source list
RUN apt-get update

#install necessary packages
RUN apt-get install g++ -y

#create and init catkin_ws
RUN mkdir -p /catkin_ws/src
RUN bash -c "source /opt/ros/indigo/setup.bash;catkin_init_workspace /catkin_ws/src"
RUN bash -c "source /opt/ros/indigo/setup.bash;catkin_make -C /catkin_ws"

#export source setup.bash to .bashrc
ADD ros_entrypoint.sh /ros_entrypoint.sh

#install necessary ros packages

#install image processing related packages
RUN apt-get install ros-indigo-camera-calibration-parsers -y
RUN apt-get install ros-indigo-ecl-command-line -y
RUN apt-get install ros-indigo-image-transport -y
RUN apt-get install ros-indigo-cv-bridge -y
RUN apt-get install ros-indigo-opencv3 -y
RUN apt-get install libzbar-dev -y
RUN apt-get install ros-indigo-tf2-ros -y
RUN apt-get install ros-indigo-mavros -y

#install gazebo 7
RUN apt-get install wget
RUN sh -c 'echo "deb http://packages.osrfoundation.org/gazebo/ubuntu-stable `lsb_release -cs` main" > /etc/apt/sources.list.d/gazebo-stable.list'
RUN wget http://packages.osrfoundation.org/gazebo.key -O - | sudo apt-key add -
RUN apt-get update
RUN apt-get install gazebo7 -y 
RUN apt-get install libgazebo7-dev -y
RUN apt-get install ros-indigo-gazebo7-ros -y

#install px4 dev tools
RUN apt-get install python-software-properties software-properties-common -y
RUN add-apt-repository ppa:george-edison55/cmake-3.x -y
RUN apt-get update
RUN apt-get install python-argparse git-core wget zip \
    python-empy qtcreator cmake build-essential genromfs -y    

#clone PX4 firmware
RUN git clone https://github.com/PX4/Firmware.git /Firmware
RUN cd /Firmware; git checkout v1.4.4 -b v1.4.4; git submodule update --init --recursive
RUN apt-get install protobuf-compiler -y
RUN cd /Firmware; make posix_sitl_default
RUN mkdir -p /Firmware/Tools/sitl_gazebo/Build
RUN cd /Firmware/Tools/sitl_gazebo/Build; cmake ..; make
RUN echo export GAZEBO_PLUGIN_PATH=${GAZEBO_PLUGIN_PATH}:/Firmware/Tools/sitl_gazebo/Build >> ~/.bashrc
RUN echo export GAZEBO_MODEL_PATH=${GAZEBO_PLUGIN_PATH}:/Firmware/Tools/sitl_gazebo/models >> ~/.bashrc
RUN echo export GAZEBO_MODEL_DATABASE_URI="" >> ~/.bashrc
RUN echo export SITL_GAZEBO_PATH=/Firmware/Tools/sitl_gazebo/Build >> ~/.bashrc

#install rosjava
RUN apt-get install ros-indigo-rosjava -y


