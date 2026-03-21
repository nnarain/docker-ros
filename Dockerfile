# Dockerfile for ROS Development
# Build with: docker build --build-arg ROS_DISTRO=humble -t ros-dev .

ARG ROS_DISTRO=jazzy

FROM ros:${ROS_DISTRO}-desktop

# Install common development tools and ros2_control
RUN apt-get update && apt-get install -y \
    python3-pip \
    git \
    libclang-dev \
    python3-vcstool \
    ros-${ROS_DISTRO}-ros2-control \
    ros-${ROS_DISTRO}-ros2-controllers \
    iproute2 \ 
    can-utils \
    tmux \
    curl \
    build-essential \
    ca-certificates \
    nano \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install Rust and Cargo
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"

# Install colcon plugins for Rust support
RUN if [ "$ROS_DISTRO" = "humble" ]; then \
        pip install --upgrade pytest && \
        pip install \
            git+https://github.com/colcon/colcon-cargo.git \
            git+https://github.com/colcon/colcon-ros-cargo.git; \
    else \
        pip install --break-system-packages pytest && \
        pip install --break-system-packages \
            git+https://github.com/colcon/colcon-cargo.git \
            git+https://github.com/colcon/colcon-ros-cargo.git; \
    fi

# Set up rosidl_rust for Rust message generation
RUN if [ "$ROS_DISTRO" = "rolling" ]; then \
        apt-get update && apt-get install -y ros-${ROS_DISTRO}-rosidl-generator-rs \
        && rm -rf /var/lib/apt/lists/*; \
    else \
        set -e && \
        mkdir -p /tmp/rosidl_rust_overlay/src && \
        git clone https://github.com/ros2-rust/rosidl_rust /tmp/rosidl_rust_overlay/src/rosidl_rust && \
        cd /tmp/rosidl_rust_overlay && \
        . /opt/ros/${ROS_DISTRO}/setup.sh && \
        colcon build --cmake-args -DCMAKE_BUILD_TYPE=Release && \
        echo "source /tmp/rosidl_rust_overlay/install/setup.bash" >> ~/.bashrc; \
    fi

# Set up ROS environment
RUN echo "source /opt/ros/${ROS_DISTRO}/setup.bash" >> ~/.bashrc

# Set working directory
WORKDIR /ros_ws

CMD ["/bin/bash"]
