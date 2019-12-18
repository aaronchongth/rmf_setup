#!/bin/bash

set -e

echo ">[BUILD]<START> Building RMF ROS 2 environment"

# Check if RMF_PATH provided
if [ -z $RMF_PATH ]; then
  echo "    RMF environment path not set, please set path to RMF_PATH."
  exit $ERRCODE;
fi

ROS2_WS_PATH=$RMF_PATH/ros2_ws

if [ ! -d $ROS2_WS_PATH ]; then
  echo "    RMF ROS 2 workspace directory [$ROS2_WS_PATH] not found."
  exit $ERRCODE
fi

pushd $ROS2_WS_PATH > /dev/null

source /opt/ros/eloquent/setup.bash

colcon build

popd > /dev/null

echo ">[BUILD]<DONE> Building RMF ROS 2 environment"
