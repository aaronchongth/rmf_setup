#!/bin/bash

set -e

echo ">[INSTALL]<START> Installing project requirements"

./install_apt_reqs.bash
./install_pip_reqs.bash

echo ">[INSTALL]<DONE> Installing project requirements"

