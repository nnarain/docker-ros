Docker containers for ROS development. These images derive from the official [ROS Docker images](https://hub.docker.com/_/ros).

| Image        | Platform    | From                 | Description                                    |
| -----        | --------    | ----                 | -----------                                    |
| ros-base     | amd64/arm64 | ROS_DISTRO-ros-base  | ROS_DISTRO + tools, usable on amd64 and arm64  |
| ros2-base    | amd64/arm64 | ROS_DISTRO-ros-base  | ROS2_DISTRO + tools, usable on amd64 and arm64 |
| ros-desktop  | amd64       | ros-base             | ros-base + SIM tools (gazebo)                  |
| ros2-desktop | amd64       | ros2-base            | ros2-base + SIM tools (gazebo)                 |
| ros-dev      | amd64       | ros-desktop          | ros-desktop + development tools                |
| ros2-dev     | amd64       | ros2-desktop         | ros2-desktop + development tools               |
