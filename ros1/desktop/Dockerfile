FROM nnarain/ros-base:latest

RUN echo 'Etc/UTC' > /etc/timezone && \
    ln -sf /usr/share/zoneinfo/Etc/UTC /etc/localtime && \
    apt-get update && \
    apt-get install -q -y --no-install-recommends tzdata && \
    rm -rf /var/lib/apt/lists/*

# Install desktop tools packages
RUN apt-get update \
    && apt-get install -y ros-${ROS_DISTRO}-gazebo-ros-pkgs \
    && apt-get install -y ros-${ROS_DISTRO}-rviz \
	&& apt-get install -y ros-${ROS_DISTRO}-rqt ros-${ROS_DISTRO}-rqt-common-plugins \
	&& apt-get install -y ros-${ROS_DISTRO}-rqt-tf-tree
