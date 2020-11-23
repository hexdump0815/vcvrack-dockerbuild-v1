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
  # if we have a source archive in the source dir use that ...
  if [ -f ../source/simde.tar.gz ]; then
    echo "INFO: using sources from the source archive"
    ( cd .. ; tar xzf source/simde.tar.gz )
  # ... otherwise get it from git and create a source archive afterwards
  else
    git clone https://github.com/simd-everywhere/simde.git
    cd simde
    # this is the version i used this script last with
    #git checkout 7a2f50407590e39031b014fc0ff7db62f2feb7d7
    ( cd ../.. ; mkdir -p source ; tar czf source/simde.tar.gz compile/simde )
    cd ..
  fi
fi

# if we have a source archive in the source dir use that ...
if [ -f ../source/Rack-source.tar.gz ]; then
  echo "INFO: using sources from the source archive"
  ( cd .. ; tar xzf source/Rack-source.tar.gz )
  cd Rack
# ... otherwise get it from git and create a source archive afterwards
else
  git clone https://github.com/VCVRack/Rack.git
  cd Rack
  git checkout v1.1.6
  git submodule update --init --recursive
  # create a backup copy of the unpatched sources if needed to build elsewhere later from them
  ( cd ../.. ; mkdir -p source ; tar czf source/Rack-source.tar.gz compile/Rack )
fi
# arch independent patches
if [ -f ../../Rack.patch ]; then
  patch -p1 < ../../Rack.patch
fi
# arch specific patches
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
