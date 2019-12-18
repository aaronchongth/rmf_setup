#!/bin/bash

set -e

function symlink_packages {
  if [ ! -d $1 ]; then
    echo "    target package directory [$1] not found."
    exit $ERRCODE
  else
    ln -s $1 $2
  fi
}

echo ">[SETUP]<START> Setting up ROS 1 workspace"

# Check if RMF_PATH provided
if [ -z $RMF_PATH ]; then
  echo "    RMF environment path not set, please set path to RMF_PATH."
  exit $ERRCODE;
fi

REPOS_PATH=$RMF_PATH/repos

if [ ! -d $REPOS_PATH ]; then
  echo "    RMF repositories not found."
  exit $ERRCODE
fi

ROS1_WS_PATH=$RMF_PATH/ros1_ws
ROS1_WS_SRC=$ROS1_WS_PATH/src

if [ ! -d $ROS1_WS_SRC ]; then
  mkdir -p $ROS1_WS_SRC
fi

pushd $ROS1_WS_SRC > /dev/null

symlink_packages $REPOS_PATH/free_fleet/clients/ros1 free_fleet_client

symlink_packages $REPOS_PATH/rmf_core_ros1_msgs rmf_core_ros1_msgs

popd > /dev/null

echo ">[SETUP]<DONE> Setting up ROS 1 workspace"
