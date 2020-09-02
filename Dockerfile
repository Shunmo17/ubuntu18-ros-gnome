##############################################################################
##                                 Base Image                               ##
##############################################################################
# original image
FROM ubuntu:18.04

ENV DEBIAN_FRONTEND noninteractive
ENV USER root

# change server for apt
RUN sed -i 's@archive.ubuntu.com@ftp.jaist.ac.jp/pub/Linux@g' /etc/apt/sources.list

##############################################################################
##                                  Common                                  ##
##############################################################################
# install ifconfig & ping
RUN apt update && apt install -y \
    iproute2 \
    iputils-ping \
    net-tools \
    terminator \
    nautilus \
    gedit \
    vim \
    firefox \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*

# install pip (after ver3.4 : pip is installed)
RUN apt update && apt install -y \
    wget \
    && apt clean \
    && rm -rf /var/lib/apt/lists/* \
    && wget https://bootstrap.pypa.io/get-pip.py && \
    python get-pip.py

# fix terminator error
RUN apt update && apt install -y \
    dbus-x11 \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*

# aiias
RUN echo "source /alias.sh">> ~/.bashrc

# copy some include files
## for ROS
COPY include/catkin_build.bash /catkin_build.bash
COPY include/ros_entrypoint.sh /ros_entrypoint.sh
## terminator setting
COPY include/config /root/.config/terminator/config
## alias setting
COPY include/alias.sh /alias.sh

##############################################################################
##                                ROS1 Install                              ##
##############################################################################
# ros distro
ENV ROS_DISTRO melodic

# setup keys
RUN apt update && apt install -my \
    wget gnupg \
    && apt clean \
    && rm -rf /var/lib/apt/lists/* \
    && apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654

# setup sources.list
## for kinetic (16.04)
RUN if [ "${ROS_DISTRO}" = "kinetic" ]; then \
    echo "deb http://packages.ros.org/ros/ubuntu xenial main" > /etc/apt/sources.list.d/ros1-latest.list; \
    fi
## for melodic (18.04)
RUN if [ "${ROS_DISTRO}" = "melodic" ]; then \
    echo "deb http://packages.ros.org/ros/ubuntu bionic main" > /etc/apt/sources.list.d/ros1-latest.list; \
    fi

# install ros
RUN apt update && apt install -y \
    ros-${ROS_DISTRO}-desktop-full \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*

# install dependecies
RUN apt update && apt install -y \
    python-rosdep \
    python-rosinstall \
    python-rosinstall-generator \
    python-wstool \
    build-essential \ 
    && apt clean \
    && rm -rf /var/lib/apt/lists/*

# initiliaze rosdep
RUN rosdep init && rosdep update

# set entrypoint
ENTRYPOINT ["/ros_entrypoint.sh"]
CMD ["bash"]

##############################################################################
##                              ROS Initialize                              ##
##############################################################################
RUN mkdir -p catkin_ws/src

# for catkin build
RUN apt update && apt install -y \
    python-catkin-tools \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /catkin_ws
RUN	/bin/bash -c "source /opt/ros/{ROS_DISTRO}/setup.bash; catkin init"

RUN echo "source /catkin_build.bash" >> ~/.bashrc

##############################################################################
##                                Install Gnome                             ##
##############################################################################
RUN apt update && apt install -y \
    ubuntu-gnome-desktop \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*

##############################################################################
##                             VNC Server Setting                           ##
##############################################################################
RUN apt update && \
    apt install -y --no-install-recommends ubuntu-desktop && \
    apt install -y tightvncserver lxde && \
    mkdir /root/.vnc

COPY include/xstartup /root/.vnc/xstartup
COPY include/passwd /root/.vnc/passwd 

RUN chmod 600 /root/.vnc/passwd

RUN echo "systemctl start gdm" >> ~/.bashrc
RUN echo "/usr/bin/vncserver :1 -geometry 1920x1080 -depth 24" >> ~/.bashrc

EXPOSE 5901
