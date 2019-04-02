#!/bin/bash

# exit on errors
set -e

MYARCH=`uname -m`

mkdir compile
cd compile
if [ "$MYARCH" == "armv7l" ] || [ "$MYARCH" == "aarch64" ]; then
  git clone https://github.com/nemequ/simde.git
  cd simde
  # this is the version i used this script last with
  git checkout a61e88057c90ceb4b0b2cf5182919717bbb0496b
  cd ..
fi
git clone https://github.com/VCVRack/Fundamental.git
cd Fundamental
#git checkout v1
# this is the version i used this script last with
git checkout 9102ada5a1ef3e72074d7f96b0c043ecab275e80
if [ -f ../../Fundamental.$MYARCH.patch ]; then
  patch -p1 < ../../Fundamental.$MYARCH.patch
fi
cd ..
git clone https://github.com/VCVRack/Befaco.git
cd Befaco
#git checkout v1
# this is the version i used this script last with
git checkout 72a2b6fab22096522914463b9bc8ecbd3513eab5
if [ -f ../../Befaco.$MYARCH.patch ]; then
  patch -p1 < ../../Befaco.$MYARCH.patch
fi
cd ..
git clone https://github.com/VCVRack/Rack.git
cd Rack
#git checkout v1
# this is the version i used this script last with
git checkout 6d755381f9141f8ec79284b8894c56331aee82bc
git submodule update --init --recursive
if [ -f ../../Rack.$MYARCH.patch ]; then
  patch -p1 < ../../Rack.$MYARCH.patch
fi
if [ "$MYARCH" == "armv7l" ] || [ "$MYARCH" == "aarch64" ]; then
  mkdir dep/include
  cd dep/include
  ln -s ../../../simde/simde/hedley.h
  ln -s ../../../simde/simde/simde-arch.h
  ln -s ../../../simde/simde/simde-common.h
  ln -s ../../../simde/simde/x86
  cd ../..
  find include/simd -type f -exec ../../simde-ify.sh {} \;
fi
cd ..
cp ../resample_neon.h ../build.sh .
