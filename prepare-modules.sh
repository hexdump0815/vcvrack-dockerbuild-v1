#!/bin/bash

# exit on errors
#set -e

WORKDIR=`dirname $0`
cd $WORKDIR
# make in an absolute path
WORKDIR=`pwd`

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

cd compile
cp ../build-modules.sh-proto build-modules.sh
cd library/repos
git checkout 95ce17d062beadd8d393ce1ebd5e5bf2057b2c3e
git submodule update --init --recursive
( cd ../../.. ; mkdir -p source ; tar czf source/library-source.tar.gz compile/library )

# arch specific patching if needed

for i in * ; do
  # surge-rack is handled separately below
  if [ "$i" != "SurgeRack" ]; then
    echo ""
    echo "===> $i"
    echo ""
    cd $i
    # arch independent patches
    if [ -f ../../../../${i}.patch ]; then
      patch -p1 < ../../../../${i}.patch
    fi
    # arch specific patches
    if [ -f ../../../../${i}.$MYARCH.patch ]; then
      patch -p1 < ../../../../${i}.$MYARCH.patch
    fi
    cd ..
  fi
done

# go back to a defined starting point to be on the safe side
cd ${WORKDIR}/compile/library/repos

# some special handling:

# AudibleInstruments
echo ""
echo "===> AudibleInstruments extra steps"
echo ""
cd AudibleInstruments
find * -type f -exec ../../../../simde-ify.sh {} \;
cd ..

# go back to a defined starting point to be on the safe side
cd ${WORKDIR}/compile/library/repos

# Bark
echo ""
echo "===> Bark extra steps"
echo ""
cd Bark
find * -type f -exec ../../../../simde-ify.sh {} \;
cd ..

# go back to a defined starting point to be on the safe side
cd ${WORKDIR}/compile/library/repos

# squinkylabs-plug1
echo ""
echo "===> squinkylabs-plug1 extra steps"
echo ""
cd squinkylabs-plug1
find * -type f -exec ../../../../simde-ify.sh {} \;
cd ..

# go back to a defined starting point to be on the safe side
cd ${WORKDIR}/compile/library/repos

# Valley
echo ""
echo "===> Valley extra steps"
echo ""
cd Valley
find * -type f -exec ../../../../simde-ify.sh {} \;
# this file gets accidently simde-ified :)
git checkout -- TopographImg.png
cd ..

# go back to a defined starting point to be on the safe side
cd ${WORKDIR}/compile/library/repos

# ML_modules
echo ""
echo "===> ML_modules extra steps"
echo ""
cd ML_modules
find * -type f -exec ../../../../simde-ify.sh {} \;
cd ..

# go back to a defined starting point to be on the safe side
cd ${WORKDIR}/compile/library/repos

# SubmarineFree
echo ""
echo "===> SubmarineFree extra steps"
echo ""
cd SubmarineFree
find * -type f -exec ../../../../simde-ify.sh {} \;
cd ..

# go back to a defined starting point to be on the safe side
cd ${WORKDIR}/compile/library/repos

# HetrickCV
echo ""
echo "===> HetrickCV extra steps"
echo ""
cd HetrickCV
# https://github.com/VCVRack/Rack/issues/1583 is fixed on master
git checkout master
cd ..

# go back to a defined starting point to be on the safe side
cd ${WORKDIR}/compile/library/repos

# BaconMusic
echo ""
echo "===> BaconMusic extra steps"
echo ""
cd BaconMusic
# https://github.com/VCVRack/Rack/issues/1583 is fixed on master
git checkout master
cd ..

# go back to a defined starting point to be on the safe side
cd ${WORKDIR}/compile/library/repos

# some extra plugins

cd ${WORKDIR}
mkdir -p compile/plugins
cd compile/plugins

# Fundamental
echo ""
echo "===> Fundamental extra plugin"
echo ""
git clone https://github.com/VCVRack/Fundamental.git
cd Fundamental
git checkout v1
git submodule update --init --recursive
( cd ../../.. ; mkdir -p source ; tar czf source/Fundamental-source.tar.gz compile/plugins/Fundamental )
if [ -f ../../../Fundamental.patch ]; then
  patch -p1 < ../../../Fundamental.patch
fi
if [ -f ../../../Fundamental.$MYARCH.patch ]; then
  patch -p1 < ../../../Fundamental.$MYARCH.patch
fi
cd ..

# go back to a defined starting point to be on the safe side
cd ${WORKDIR}/compile/plugins

# VCV-Recorder
echo ""
echo "===> VCV-Recorder extra plugin"
echo ""
git clone https://github.com/VCVRack/VCV-Recorder
cd VCV-Recorder
if [ "$MYARCH" = "macos" ]; then
  # rolle back to before opus as otherwise the fails on it on macos
  git checkout 85aac9cce1bb6295141786a48e4a800b1168bae0
else
  git checkout v1
fi
git submodule update --init --recursive
( cd ../../.. ; mkdir -p source ; tar czf source/VCV-Recorder-source.tar.gz compile/plugins/VCV-Recorder )
if [ -f ../../../VCV-Recorder.patch ]; then
  patch -p1 < ../../../VCV-Recorder.patch
fi
if [ -f ../../../VCV-Recorder.$MYARCH.patch ]; then
  patch -p1 < ../../../VCV-Recorder.$MYARCH.patch
fi
cd ..

# go back to a defined starting point to be on the safe side
cd ${WORKDIR}/compile/plugins

# vcv-link
echo ""
echo "===> vcv-link extra plugin"
echo ""
git clone https://github.com/stellare-modular/vcv-link
cd vcv-link
git checkout feature/v1
git submodule update --init --recursive
( cd ../../.. ; mkdir -p source ; tar czf source/vcv-link-source.tar.gz compile/plugins/vcv-link )
if [ -f ../../../vcv-link.patch ]; then
  patch -p1 < ../../../vcv-link.patch
fi
if [ -f ../../../vcv-link.$MYARCH.patch ]; then
  patch -p1 < ../../../vcv-link.$MYARCH.patch
fi
cd ..

# go back to a defined starting point to be on the safe side
cd ${WORKDIR}/compile/plugins

# LRTRack
echo ""
echo "===> LRTRack extra plugin"
echo ""
git clone https://github.com/lindenbergresearch/LRTRack
cd LRTRack
git checkout master
git submodule update --init --recursive
( cd ../../.. ; mkdir -p source ; tar czf source/LRTRack-source.tar.gz compile/plugins/LRTRack )
if [ -f ../../../LRTRack.patch ]; then
  patch -p1 < ../../../LRTRack.patch
fi
if [ -f ../../../LRTRack.$MYARCH.patch ]; then
  patch -p1 < ../../../LRTRack.$MYARCH.patch
fi
cd ..

# go back to a defined starting point to be on the safe side
cd ${WORKDIR}/compile/plugins

# vcvrack-packgamma
echo ""
echo "===> vcvrack-packgamma extra plugin"
echo ""
git clone https://github.com/stoermelder/vcvrack-packgamma.git
cd vcvrack-packgamma
git checkout master
git submodule update --init --recursive
( cd ../../.. ; mkdir -p source ; tar czf source/vcvrack-packgamma-source.tar.gz compile/plugins/vcvrack-packgamma )
if [ -f ../../../vcvrack-packgamma.patch ]; then
  patch -p1 < ../../../vcvrack-packgamma.patch
fi
if [ -f ../../../vcvrack-packgamma.$MYARCH.patch ]; then
  patch -p1 < ../../../vcvrack-packgamma.$MYARCH.patch
fi
cd dep/Gamma
if [ -f ../../../../../vcvrack-packgamma-dep-Gamma.$MYARCH.patch ]; then
  patch -p1 < ../../../../../vcvrack-packgamma-dep-Gamma.$MYARCH.patch
fi
cd ../..
cd ..

# go back to a defined starting point to be on the safe side
cd ${WORKDIR}/compile/plugins

# surge-rack
echo ""
echo "===> surge-rack extra plugin"
echo ""
git clone https://github.com/surge-synthesizer/surge-rack
cd surge-rack
git checkout release/1.beta1.4
git submodule update --init --recursive
( cd ../../.. ; mkdir -p source ; tar czf source/surge-rack-source.tar.gz compile/plugins/surge-rack )
if [ -f ../../../surge-rack.$MYARCH.patch ]; then
  patch -p1 < ../../../surge-rack.$MYARCH.patch
fi
# special patching for surge-rack in the surge subdir
cd surge
if [ -f ../../../../surge-rack-surge.$MYARCH.patch ]; then
  patch -p1 < ../../../../surge-rack-surge.$MYARCH.patch
fi
cd ..
find * -type f -exec ../../../simde-ify.sh {} \;
cd ..

# go back to a defined point
cd ${WORKDIR}
