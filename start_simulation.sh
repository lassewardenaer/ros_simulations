#!/bin/bash

# Source the ROS and workspace setup files
source /opt/ros/noetic/setup.bash
source /home/ros/catkin_ws/devel/setup.bash

# Set the TurtleBot3 model
export TURTLEBOT3_MODEL=waffle

# Launch the Gazebo simulation with TurtleBot3
roslaunch turtlebot3_gazebo turtlebot3_world.launch
