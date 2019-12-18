#!/bin/bash

set -e

echo ">[INSTALL]<START> Installing apt requirements"

sudo apt-get install \
	build-essential \
	cmake \
	git \

echo ">[INSTALL]<DONE> Installing apt requirements"

