#!/bin/bash

set -e

function public_clone {
  IFS="/" read -ra repo_parts <<< $1
  if [ -d ${repo_parts[1]} ]; then
    echo "    repository [$1] already exists."
  else
    git clone https://github.com/$1.git
  fi
}

function dev_clone {
  IFS="/" read -ra repo_parts <<< $1
  if [ -d ${repo_parts[1]} ]; then
    echo "    repository [$1] already exists."
  else
    git clone ssh://git@github.com/$1.git
  fi
}

declare -a repos=(
  "osrf/free_fleet"
  "osrf/rmf_core"
  "osrf/rmf_schedule_visualizer"
  "osrf/rmf_core_ros1_msgs"
  "osrf/traffic_editor"
)

echo ">[SETUP]<START> Setting up RMF repositories"

# Check if RMF_PATH provided
if [ -z $RMF_PATH ]; then
  echo "    RMF environment path not set, please set path to RMF_PATH."
  exit $ERRCODE;
fi

REPOS_PATH=$RMF_PATH/repos

if [ ! -d $REPOS_PATH ]; then
  mkdir -p $REPOS_PATH
fi

pushd $REPOS_PATH > /dev/null

for i in "${repos[@]}"
do
  if [ $DEV ]; then
    dev_clone $i
  else
    public_clone $i
  fi
done

popd > /dev/null

echo ">[SETUP]<DONE> Setting up RMF repositories"
