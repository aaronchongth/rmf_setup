#!/bin/bash

set -e

echo ">[BUILD]<START> Building RMF ROS 1 environment"

# Check if RMF_PATH provided
if [ -z $RMF_PATH ]; then
  echo "    RMF environment path not set, please set path to RMF_PATH."
  exit $ERRCODE;
fi

ROS1_WS_PATH=$RMF_PATH/ros1_ws

if [ ! -d $ROS1_WS_PATH ]; then
  echo "    RMF ROS 1 workspace directory [$ROS1_WS_PATH] not found."
  exit $ERRCODE
fi

pushd $ROS1_WS_PATH > /dev/null

source /opt/ros/melodic/setup.bash

catkin build

popd > /dev/null

echo ">[BUILD]<DONE> Building RMF ROS 1 environment"
