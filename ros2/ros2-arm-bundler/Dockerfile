#
# ROS2 Bundler for ARM64 architecture
#
# @author Natesh Narain <nnaraindev@gmail.com>
#
FROM arm64v8/ubuntu:latest

# Avoid warnings by switching to noninteractive
ENV DEBIAN_FRONTEND=noninteractive

ENV ROS_DISTRO=foxy
ENV LOCALE=en_US

RUN apt-get update \
    # Setup locales
    && apt-get install -y locales \
    && locale-gen ${LOCALE} ${LOCALE}.UTF-8 \
    && update-locale LC_ALL=${LOCALE}.UTF-8 LANG=${LOCALE}.UTF-8 \
    && export LANG=${LOCALE}.UTF-8 \
    # Setup ROS deps
    && apt-get install -y curl wget gnupg2 lsb-release \
    && curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | apt-key add - \
    && sh -c 'echo "deb [arch=$(dpkg --print-architecture)] http://packages.ros.org/ros2/ubuntu $(lsb_release -cs) main" > /etc/apt/sources.list.d/ros2-latest.list' \
    # Install ROS and build tools
    && apt-get update \
    && apt-get install -y ros-${ROS_DISTRO}-ros-base \
    && apt-get install python3-apt python3-pip \
    && apt-get install python3-colcon-common-extensions \
    && pip3 install colcon-ros-bundle \
    && echo "source /opt/ros/${ROS_DISTRO}/setup.bash" >> ~/.bashrc \
    # Install other deps
    && apt-get install -y libboost-all-dev \
    # Setup rosdep
    && rosdep init \
    && rosdep update \
    # APT keys
    && wget http://packages.osrfoundation.org/gazebo.key -O- | apt-key add -
