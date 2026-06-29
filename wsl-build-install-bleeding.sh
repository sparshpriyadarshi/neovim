#!/usr/bin/bash
set -eux # quit if error...

ARCH="x86_64"
BRANCHTYPE="master" #todo custom later on..

git checkout master #sanity

echo "switching and pulling repo ${BRANCHTYPE} changes..."
git checkout ${BRANCHTYPE}
git pull origin ${BRANCHTYPE}

echo "installing build prerequisites"
sudo apt-get install ninja-build gettext cmake build-essential

echo "cleaning..."
make distclean

echo "building..."
make CMAKE_BUILD_TYPE=RelWithDebInfo
cd build && cpack -G DEB && sudo dpkg -i nvim-linux-${ARCH}.deb

echo "verifying..."
nvim --version && which nvim # should be debug build in /usr/bin/nvim

git checkout master

set +eux
echo "done..."


