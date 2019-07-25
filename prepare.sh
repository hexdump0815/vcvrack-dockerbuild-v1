#!/bin/bash

# exit on errors
set -e

WORKDIR=`dirname $0`
cd $WORKDIR

MYARCH=`uname -m`
MYUNAME=`uname`

if [ "$MYUNAME" = "Darwin" ]; then
  MYARCH="macos"
else
  MYOS=`uname -o`
  if [ "$MYOS" = "Msys" ]; then
    if [ "$MSYSTEM_CARCH" = "x86_64" ]; then
      MYARCH="win64"
    else
      MYARCH="win32"
    fi
  fi
fi

mkdir -p compile
cd compile
if [ "$MYARCH" == "armv7l" ] || [ "$MYARCH" == "aarch64" ]; then
  git clone https://github.com/nemequ/simde.git
  cd simde
  # this is the version i used this script last with
  git checkout a61e88057c90ceb4b0b2cf5182919717bbb0496b
  cd ..
fi

git clone https://github.com/VCVRack/Rack.git
cd Rack
git checkout v1.1.3
# this is the version i used this script last with
#git checkout xy
git submodule update --init --recursive
if [ -f ../../Rack.$MYARCH.patch ]; then
  patch -p1 < ../../Rack.$MYARCH.patch
fi
if [ "$MYARCH" == "armv7l" ] || [ "$MYARCH" == "aarch64" ]; then
  mkdir -p dep/include
  cd dep/include
  ln -s ../../../simde/simde/hedley.h
  ln -s ../../../simde/simde/simde-arch.h
  ln -s ../../../simde/simde/simde-common.h
  ln -s ../../../simde/simde/x86
  cd ../..
  find include/simd -type f -exec ../../simde-ify.sh {} \;
fi
cd ..
cp ../resample_neon.h .
cp ../build.sh-proto build.sh

git clone https://github.com/VCVRack/library.git
cd library/manifests
( for i in `grep sourceUrl * | awk '{print $3}' | sed 's,",,g;s,\,,,g'`; do echo $i ; done ) | grep http | sed 's,/$,,g;s,\.git$,,g' | sed 's,/blob.*,,g;s,/tree.*,,g' | grep -v "VCVRack/Rack" | sort -u > /tmp/pluginurls.txt
cd ../..
