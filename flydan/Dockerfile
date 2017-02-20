FROM ros:indigo-ros-base

#update apt-get source list
RUN apt-get update

#install necessary packages
RUN apt-get install g++ wget -y

#install image processing related packages
RUN apt-get install ros-indigo-camera-calibration-parsers ros-indigo-ecl-command-line ros-indigo-image-transport ros-indigo-cv-bridge ros-indigo-opencv3 libzbar-dev ros-indigo-tf2-ros ros-indigo-mavros

#install gazebo 7
RUN sh -c 'echo "deb http://packages.osrfoundation.org/gazebo/ubuntu-stable `lsb_release -cs` main" > /etc/apt/sources.list.d/gazebo-stable.list'
RUN wget http://packages.osrfoundation.org/gazebo.key -O - | sudo apt-key add -
RUN apt-get update
RUN apt-get install gazebo7 libgazebo7-dev ros-indigo-gazebo7-ros -y 

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

#install rosjava
RUN apt-get install ros-indigo-rosjava -y

# install packages
RUN apt-get update && apt-get install -q -y \
    build-essential \
    cmake \
    imagemagick \
    libboost-all-dev \
    libgts-dev \
    libjansson-dev \
    libtinyxml-dev \
    mercurial \
    nodejs \
    nodejs-legacy \
    npm \
    pkg-config \
    psmisc\
    && rm -rf /var/lib/apt/lists/*
    
# clone gzweb
RUN hg clone https://bitbucket.org/osrf/gzweb ~/gzweb

# build gzweb
RUN cd ~/gzweb \
    && hg up default \
    && ./deploy.sh -m

#create and init catkin_ws
RUN mkdir -p /catkin_ws/src
RUN bash -c "source /opt/ros/indigo/setup.bash;catkin_init_workspace /catkin_ws/src"
RUN bash -c "source /opt/ros/indigo/setup.bash;catkin_make -C /catkin_ws"

# setup entrypoint
COPY ./ros_entrypoint.sh /

ENTRYPOINT ["/ros_entrypoint.sh"]
CMD ["bash"]