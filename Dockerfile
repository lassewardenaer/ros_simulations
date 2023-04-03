FROM nvidia/cudagl:11.1.1-base-ubuntu20.04

# Set the working directory
WORKDIR /home/ros/catkin_ws
 
# Minimal setup
RUN apt-get update \
 && apt-get install -y locales lsb-release
ARG DEBIAN_FRONTEND=noninteractive
RUN dpkg-reconfigure locales
# Install ROS Noetic
RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
RUN apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
RUN apt-get update \
 && apt-get install -y --no-install-recommends ros-noetic-desktop-full
RUN apt-get install -y --no-install-recommends python3-rosdep
RUN apt-get install -y --no-install-recommends git 
RUN rosdep init \
 && rosdep fix-permissions \
 && rosdep update
RUN  apt-get update && apt-get install libgl1-mesa-glx
RUN echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc

RUN mkdir -p turtlebot3_simulation_ws/src

COPY submodules/turtlebot3 /home/ros/catkin_ws/src/turtlebot3
COPY submodules/turtlebot3_msgs /home/ros/catkin_ws/src/turtlebot3_msgs
COPY submodules/turtlebot3_simulations /home/ros/catkin_ws/src/turtlebot3_simulations

WORKDIR /home/ros/catkin_ws/turtlebot3_simulation_ws

RUN apt-get install -y build-essential

# Build the workspace
WORKDIR /home/ros/catkin_ws
RUN /bin/bash -c "source /opt/ros/noetic/setup.bash && catkin_make"

COPY start_simulation.sh .

CMD ["./start_simulation.sh"]
