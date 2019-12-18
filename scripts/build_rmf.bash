#!/bin/bash

set -e

echo ">[BUILD]<START> Building RMF environment"

SCRIPT_PATH="$( cd "$(dirname "$0")" ; pwd -P )"

# Check if RMF_PATH provided
if [ -z $RMF_PATH ]; then
  echo "    RMF environment path not set, please set path to RMF_PATH."
  exit $ERRCODE;
fi

# Handle relative or absolute path cases
RMF_PATH=`realpath $RMF_PATH`
echo "    RMF environment path: $RMF_PATH"

if [ ! -d $RMF_PATH ]; then
  echo "    RMF environment directory not found."
  exit $ERROCDE
fi

pushd $SCRIPT_PATH > /dev/null

./build_ros1_ws.bash

./build_ros2_ws.bash

popd > /dev/null

echo ">[BUILD]<DONE> Building RMF environment"
