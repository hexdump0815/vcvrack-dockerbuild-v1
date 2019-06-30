#!/bin/bash

# exit on errors
set -e

WORKDIR=`dirname $0`
cd $WORKDIR

MYARCH=`uname -m`

mkdir -p compile/plugins
cd compile
cp ../build-modules.sh-proto build-modules.sh
cd plugins

# Fundamental
echo Fundamental
# this is the version i used this script last with
#git checkout 01fe49d256df8d10c901e1cbad693bb5ec50f04a
git clone https://github.com/VCVRack/Fundamental.git
cd Fundamental
git checkout v1
git submodule update --init --recursive
if [ -f ../../../Fundamental.$MYARCH.patch ]; then
  patch -p1 < ../../../Fundamental.$MYARCH.patch
fi
cd ..

# AudibleInstruments
echo AudibleInstruments
# this is the version i used this script last with
#git checkout xy
git clone https://github.com/VCVRack/AudibleInstruments.git
cd AudibleInstruments
git checkout v1
git submodule update --init --recursive
if [ -f ../../../AudibleInstruments.$MYARCH.patch ]; then
  patch -p1 < ../../../AudibleInstruments.$MYARCH.patch
fi
cd ..

# Befaco
echo Befaco
# this is the version i used this script last with
#git checkout 72a2b6fab22096522914463b9bc8ecbd3513eab5
git clone https://github.com/VCVRack/Befaco.git
cd Befaco
git checkout v1
git submodule update --init --recursive
if [ -f ../../../Befaco.$MYARCH.patch ]; then
  patch -p1 < ../../../Befaco.$MYARCH.patch
fi
cd ..

# ESeries
echo ESeries
# this is the version i used this script last with
#git checkout xy
git clone https://github.com/VCVRack/ESeries.git
cd ESeries
git checkout v1
git submodule update --init --recursive
if [ -f ../../../ESeries.$MYARCH.patch ]; then
  patch -p1 < ../../../ESeries.$MYARCH.patch
fi
cd ..

# SquinkyVCV
echo SquinkyVCV
# this is the version i used this script last with
#git checkout xy
git clone https://github.com/squinkylabs/SquinkyVCV
cd SquinkyVCV
git checkout master
git submodule update --init --recursive
if [ -f ../../../SquinkyVCV.$MYARCH.patch ]; then
  patch -p1 < ../../../SquinkyVCV.$MYARCH.patch
fi
find . -type f -exec ../../../simde-ify.sh {} \;
cd ..

# BogaudioModules
echo BogaudioModules
# this is the version i used this script last with
#git checkout xy
git clone https://github.com/bogaudio/BogaudioModules
cd BogaudioModules
git checkout v1
git submodule update --init --recursive
if [ -f ../../../BogaudioModules.$MYARCH.patch ]; then
  patch -p1 < ../../../BogaudioModules.$MYARCH.patch
fi
cd ..

# ValleyRackFree
echo ValleyRackFree
# this is the version i used this script last with
#git checkout xy
git clone https://github.com/ValleyAudio/ValleyRackFree
cd ValleyRackFree
git checkout v1.0
git submodule update --init --recursive
find . -type f -exec ../../../simde-ify.sh {} \;
if [ -f ../../../ValleyRackFree.$MYARCH.patch ]; then
  patch -p1 < ../../../ValleyRackFree.$MYARCH.patch
fi
cd ..

# ML_modules
echo ML_modules
# this is the version i used this script last with
#git checkout xy
git clone https://github.com/martin-lueders/ML_modules
cd ML_modules
git checkout v1
git submodule update --init --recursive
if [ -f ../../../ML_modules.$MYARCH.patch ]; then
  patch -p1 < ../../../ML_modules.$MYARCH.patch
fi
find . -type f -exec ../../../simde-ify.sh {} \;
cd ..

# ImpromptuModular
echo ImpromptuModular
# this is the version i used this script last with
#git checkout xy
git clone https://github.com/MarcBoule/ImpromptuModular
cd ImpromptuModular
git checkout v1
git submodule update --init --recursive
if [ -f ../../../ImpromptuModular.$MYARCH.patch ]; then
  patch -p1 < ../../../ImpromptuModular.$MYARCH.patch
fi
cd ..

# STS
echo STS
# this is the version i used this script last with
#git checkout xy
git clone https://github.com/SmallTownSound/STS
cd STS
git checkout V1
git submodule update --init --recursive
if [ -f ../../../STS.$MYARCH.patch ]; then
  patch -p1 < ../../../STS.$MYARCH.patch
fi
cd ..

# JW-Modules
echo JW-Modules
# this is the version i used this script last with
#git checkout xy
git clone https://github.com/jeremywen/JW-Modules
cd JW-Modules
git checkout v1
git submodule update --init --recursive
if [ -f ../../../JW-Modules.$MYARCH.patch ]; then
  patch -p1 < ../../../JW-Modules.$MYARCH.patch
fi
cd ..

# surge-rack
echo surge-rack
# this is the version i used this script last with
#git checkout xy
git clone https://github.com/surge-synthesizer/surge-rack
cd surge-rack
git checkout release/1.beta1.0
git submodule update --init --recursive
if [ -f ../../../surge-rack.$MYARCH.patch ]; then
  patch -p1 < ../../../surge-rack.$MYARCH.patch
fi
# special patching for surge-rack in the surge subdir
cd surge
if [ -f ../../../../surge-rack-surge.$MYARCH.patch ]; then
  patch -p1 < ../../../../surge-rack-surge.$MYARCH.patch
fi
cd ..
find . -type f -exec ../../../simde-ify.sh {} \;
cd ..

# AS
echo AS
# this is the version i used this script last with
#git checkout xy
git clone https://github.com/AScustomWorks/AS
cd AS
git checkout master
git submodule update --init --recursive
if [ -f ../../../AS.$MYARCH.patch ]; then
  patch -p1 < ../../../AS.$MYARCH.patch
fi
cd ..

# Geodesics
echo Geodesics
# this is the version i used this script last with
#git checkout xy
git clone https://github.com/MarcBoule/Geodesics
cd Geodesics
git checkout v1
git submodule update --init --recursive
if [ -f ../../../Geodesics.$MYARCH.patch ]; then
  patch -p1 < ../../../Geodesics.$MYARCH.patch
fi
cd ..

# vcv-link
echo vcv-link
# this is the version i used this script last with
#git checkout xy
git clone https://github.com/stellare-modular/vcv-link
cd vcv-link
git checkout feature/v1
git submodule update --init --recursive
if [ -f ../../../vcv-link.$MYARCH.patch ]; then
  patch -p1 < ../../../vcv-link.$MYARCH.patch
fi
cd ..

# synthkit
echo synthkit
# this is the version i used this script last with
#git checkout xy
git clone https://github.com/jerrysievert/synthkit
cd synthkit
git checkout v1.0
git submodule update --init --recursive
if [ -f ../../../synthkit.$MYARCH.patch ]; then
  patch -p1 < ../../../synthkit.$MYARCH.patch
fi
cd ..

# DrumKit
echo DrumKit
# this is the version i used this script last with
#git checkout xy
git clone https://github.com/JerrySievert/DrumKit
cd DrumKit
git checkout v1.0
git submodule update --init --recursive
if [ -f ../../../DrumKit.$MYARCH.patch ]; then
  patch -p1 < ../../../DrumKit.$MYARCH.patch
fi
cd ..

# CharredDesert
echo CharredDesert
# this is the version i used this script last with
#git checkout xy
git clone https://github.com/JerrySievert/CharredDesert
cd CharredDesert
git checkout v1.0
git submodule update --init --recursive
if [ -f ../../../CharredDesert.$MYARCH.patch ]; then
  patch -p1 < ../../../CharredDesert.$MYARCH.patch
fi
cd ..

# LRTRack
echo LRTRack
# this is the version i used this script last with
#git checkout xy
git clone https://github.com/lindenbergresearch/LRTRack.git
cd LRTRack
git checkout v1.0.0
git submodule update --init --recursive
if [ -f ../../../LRTRack.$MYARCH.patch ]; then
  patch -p1 < ../../../LRTRack.$MYARCH.patch
fi
cd ..

# cf
echo cf
# this is the version i used this script last with
#git checkout xy
git clone https://github.com/cfoulc/cf.git
cd cf
git checkout v1
git submodule update --init --recursive
if [ -f ../../../cf.$MYARCH.patch ]; then
  patch -p1 < ../../../cf.$MYARCH.patch
fi
cd ..
