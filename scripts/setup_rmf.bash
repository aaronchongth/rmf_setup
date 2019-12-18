#!/bin/bash

set -e

DEV=''

print_help() {
  printf "Help: -d for development environment"
}

while getopts 'd' flag; do
  case "$flag" in
    d) DEV='true' ;;
    h) print_help
       exit 1 ;;
  esac
done

# Checks if setting up public or development RMF environment
if [ $DEV ]; then
  echo ">[SETUP]<START> Setting up development RMF environment"
else
  echo ">[SETUP]<START> Setting up RMF environment"
fi

# Check if RMF_PATH provided
if [ -z $RMF_PATH ]; then
  echo "    RMF environment path not set, please set path to RMF_PATH."
  exit $ERRCODE;
fi

# Handle relative or absolute path cases
RMF_PATH=`realpath $RMF_PATH`
echo "    RMF environment path: $RMF_PATH"

# Creates the RMF environment directory if not available
if [ ! -d $RMF_PATH ]; then
  echo "    RMF environment not found, making a new directory."
  mkdir -p $RMF_PATH
fi

# Goes to script directory and starts executing scripts
SCRIPT_PATH="$( cd "$(dirname "$0")" ; pwd -P )"
pushd $SCRIPT_PATH > /dev/null

# Clones all the open source RMF repositories
./setup_repos.bash

# Sets up the RMF ROS 1 workspace
./setup_ros1_ws.bash 

# Sets up the RMF ROS 2 workspace
./setup_ros2_ws.bash

popd > /dev/null

echo ">[SETUP]<DONE> Setting up RMF environtment"
