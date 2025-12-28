# Dockerfile for ROS Development
# Build with: docker build --build-arg ROS_DISTRO=humble -t ros-dev .

ARG ROS_DISTRO=jazzy

FROM ros:${ROS_DISTRO}

# Install common development tools and ros2_control
RUN apt-get update && apt-get install -y \
    python3-pip \
    git \
    ros-${ROS_DISTRO}-ros2-control \
    ros-${ROS_DISTRO}-ros2-controllers \
    iproute2 \ 
    can-utils \
    tmux \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set up ROS environment
RUN echo "source /opt/ros/${ROS_DISTRO}/setup.bash" >> ~/.bashrc

# Set working directory
WORKDIR /ros_ws

CMD ["/bin/bash"]
