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

# if we have a source archive in the source dir use that ...
if [ -f ../source/library-source.tar.gz ]; then
  echo "INFO: using sources from the source archive"
  ( cd .. ; tar xzf source/library-source.tar.gz )
  cd library
# ... otherwise get it from git and create a source archive afterwards
else
  git clone https://github.com/VCVRack/library.git
  cd library
  # this is the version i used this script last with
  #git checkout 52397d8150e073fcf3355267c776bfb61a4699d6
  git submodule update --init --recursive
  ( cd ../.. ; mkdir -p source ; tar czf source/library-source.tar.gz compile/library )
fi

cd repos

# replace missing soundpipe (which seems to be gone on github) in RJModules with backup repo
cd RJModules/dep
rm -rf soundpipe
git clone https://github.com/hexdump0815/soundpipe-backup.git soundpipe
cd ../..

# arch specific patching if needed

for i in * ; do
  # SurgeRack is handled separately below
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
# this file gets accidently simde-ified :)
git checkout -- design/Warps.ai
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
git checkout main
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
# if we have a source archive in the source dir use that ...
if [ -f ../../source/Fundamental-source.tar.gz ]; then
  echo "INFO: using sources from the source archive"
  ( cd ../.. ; tar xzf source/Fundamental-source.tar.gz )
  cd Fundamental
# ... otherwise get it from git and create a source archive afterwards
else
  git clone https://github.com/VCVRack/Fundamental.git
  cd Fundamental
  git checkout v1
  git submodule update --init --recursive
  ( cd ../../.. ; mkdir -p source ; tar czf source/Fundamental-source.tar.gz compile/plugins/Fundamental )
fi
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
# if we have a source archive in the source dir use that ...
if [ -f ../../source/VCV-Recorder-source.tar.gz ]; then
  echo "INFO: using sources from the source archive"
  ( cd ../.. ; tar xzf source/VCV-Recorder-source.tar.gz )
  cd VCV-Recorder
# ... otherwise get it from git and create a source archive afterwards
else
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
fi
if [ -f ../../../VCV-Recorder.patch ]; then
  patch -p1 < ../../../VCV-Recorder.patch
fi
if [ -f ../../../VCV-Recorder.$MYARCH.patch ]; then
  patch -p1 < ../../../VCV-Recorder.$MYARCH.patch
fi
cd ..

# go back to a defined starting point to be on the safe side
cd ${WORKDIR}/compile/plugins

# VCV-Prototype
echo ""
echo "===> VCV-Prototype extra plugin"
echo ""
# if we have a source archive in the source dir use that ...
if [ -f ../../source/VCV-Prototype-source.tar.gz ]; then
  echo "INFO: using sources from the source archive"
  ( cd ../.. ; tar xzf source/VCV-Prototype-source.tar.gz )
  cd VCV-Prototype
# ... otherwise get it from git and create a source archive afterwards
else
  git clone https://github.com/VCVRack/VCV-Prototype
  cd VCV-Prototype
  git checkout v1
  git submodule update --init --recursive
  ( cd ../../.. ; mkdir -p source ; tar czf source/VCV-Prototype-source.tar.gz compile/plugins/VCV-Prototype )
fi
if [ -f ../../../VCV-Prototype.patch ]; then
  patch -p1 < ../../../VCV-Prototype.patch
fi
if [ -f ../../../VCV-Prototype.$MYARCH.patch ]; then
  patch -p1 < ../../../VCV-Prototype.$MYARCH.patch
fi
cd ..

# go back to a defined starting point to be on the safe side
cd ${WORKDIR}/compile/plugins

# vcv-link
echo ""
echo "===> vcv-link extra plugin"
echo ""
# if we have a source archive in the source dir use that ...
if [ -f ../../source/vcv-link-source.tar.gz ]; then
  echo "INFO: using sources from the source archive"
  ( cd ../.. ; tar xzf source/vcv-link-source.tar.gz )
  cd vcv-link
# ... otherwise get it from git and create a source archive afterwards
else
  git clone https://github.com/stellare-modular/vcv-link
  cd vcv-link
  git checkout feature/v2
  git submodule update --init --recursive
  ( cd ../../.. ; mkdir -p source ; tar czf source/vcv-link-source.tar.gz compile/plugins/vcv-link )
fi
if [ -f ../../../vcv-link.patch ]; then
  patch -p1 < ../../../vcv-link.patch
fi
if [ -f ../../../vcv-link.$MYARCH.patch ]; then
  patch -p1 < ../../../vcv-link.$MYARCH.patch
fi
cd ..

# go back to a defined starting point to be on the safe side
cd ${WORKDIR}/compile/plugins

# sts-backup
echo ""
echo "===> sts-backup extra plugin"
echo ""
# if we have a source archive in the source dir use that ...
if [ -f ../../source/sts-backup-source.tar.gz ]; then
  echo "INFO: using sources from the source archive"
  ( cd ../.. ; tar xzf source/sts-backup-source.tar.gz )
  cd sts-backup
# ... otherwise get it from git and create a source archive afterwards
else
  git clone https://github.com/hexdump0815/sts-backup.git
  cd sts-backup
  git checkout master
  git submodule update --init --recursive
  ( cd ../../.. ; mkdir -p source ; tar czf source/sts-backup-source.tar.gz compile/plugins/sts-backup )
fi
if [ -f ../../../sts-backup.patch ]; then
  patch -p1 < ../../../sts-backup.patch
fi
if [ -f ../../../sts-backup.$MYARCH.patch ]; then
  patch -p1 < ../../../sts-backup.$MYARCH.patch
fi
cd ..

# go back to a defined starting point to be on the safe side
cd ${WORKDIR}/compile/plugins

# LRTRack
echo ""
echo "===> LRTRack extra plugin"
echo ""
# if we have a source archive in the source dir use that ...
if [ -f ../../source/LRTRack-source.tar.gz ]; then
  echo "INFO: using sources from the source archive"
  ( cd ../.. ; tar xzf source/LRTRack-source.tar.gz )
  cd LRTRack
# ... otherwise get it from git and create a source archive afterwards
else
  git clone https://github.com/lindenbergresearch/LRTRack
  cd LRTRack
  git checkout master
  git submodule update --init --recursive
  ( cd ../../.. ; mkdir -p source ; tar czf source/LRTRack-source.tar.gz compile/plugins/LRTRack )
fi
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
# if we have a source archive in the source dir use that ...
if [ -f ../../source/vcvrack-packgamma-source.tar.gz ]; then
  echo "INFO: using sources from the source archive"
  ( cd ../.. ; tar xzf source/vcvrack-packgamma-source.tar.gz )
  cd vcvrack-packgamma
# ... otherwise get it from git and create a source archive afterwards
else
  git clone https://github.com/stoermelder/vcvrack-packgamma.git
  cd vcvrack-packgamma
  git checkout v1
  git submodule update --init --recursive
  ( cd ../../.. ; mkdir -p source ; tar czf source/vcvrack-packgamma-source.tar.gz compile/plugins/vcvrack-packgamma )
fi
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

# vcvrack-packtau
echo ""
echo "===> vcvrack-packtau extra plugin"
echo ""
# if we have a source archive in the source dir use that ...
if [ -f ../../source/vcvrack-packtau-source.tar.gz ]; then
  echo "INFO: using sources from the source archive"
  ( cd ../.. ; tar xzf source/vcvrack-packtau-source.tar.gz )
  cd vcvrack-packtau
# ... otherwise get it from git and create a source archive afterwards
else
  git clone https://github.com/stoermelder/vcvrack-packtau.git
  cd vcvrack-packtau
  git checkout v1
  git submodule update --init --recursive
  ( cd ../../.. ; mkdir -p source ; tar czf source/vcvrack-packtau-source.tar.gz compile/plugins/vcvrack-packtau )
fi
if [ -f ../../../vcvrack-packtau.patch ]; then
  patch -p1 < ../../../vcvrack-packtau.patch
fi
if [ -f ../../../vcvrack-packtau.$MYARCH.patch ]; then
  patch -p1 < ../../../vcvrack-packtau.$MYARCH.patch
fi
cd ..

# go back to a defined starting point to be on the safe side
cd ${WORKDIR}/compile/plugins

# surge-rack
echo ""
echo "===> surge-rack extra plugin"
echo ""
# if we have a source archive in the source dir use that ...
if [ -f ../../source/surge-rack-source.tar.gz ]; then
  echo "INFO: using sources from the source archive"
  ( cd ../.. ; tar xzf source/surge-rack-source.tar.gz )
  cd surge-rack
# ... otherwise get it from git and create a source archive afterwards
else
  git clone https://github.com/surge-synthesizer/surge-rack
  cd surge-rack
  git checkout release/1.7.1.2
  git submodule update --init --recursive
  ( cd ../../.. ; mkdir -p source ; tar czf source/surge-rack-source.tar.gz compile/plugins/surge-rack )
fi
if [ -f ../../../surge-rack.$MYARCH.patch ]; then
  patch -p1 < ../../../surge-rack.$MYARCH.patch
fi
# special patching for surge-rack in the surge subdir
cd surge
if [ -f ../../../../surge-rack-surge.$MYARCH.patch ]; then
  patch -p1 < ../../../../surge-rack-surge.$MYARCH.patch
fi
cd ..
# this seems to no longer be required with 1.7.1
# find * -type f -exec ../../../simde-ify.sh {} \;
cd ..

# go back to a defined starting point to be on the safe side
cd ${WORKDIR}/compile/plugins

# 4rack
echo ""
echo "===> 4rack extra plugin"
echo ""
# if we have a source archive in the source dir use that ...
if [ -f ../../source/4rack-source.tar.gz ]; then
  echo "INFO: using sources from the source archive"
  ( cd ../.. ; tar xzf source/4rack-source.tar.gz )
  cd 4rack
# ... otherwise get it from git and create a source archive afterwards
else
  git clone https://github.com/Moaneschien/4rack
  cd 4rack
  git checkout master
  git submodule update --init --recursive
  ( cd ../../.. ; mkdir -p source ; tar czf source/4rack-source.tar.gz compile/plugins/4rack )
fi
if [ -f ../../../4rack.patch ]; then
  patch -p1 < ../../../4rack.patch
fi
if [ -f ../../../4rack.$MYARCH.patch ]; then
  patch -p1 < ../../../4rack.$MYARCH.patch
fi
cd ..

# go back to a defined starting point to be on the safe side
cd ${WORKDIR}/compile/plugins

# CAOplugs
echo ""
echo "===> CAOplugs extra plugin"
echo ""
# if we have a source archive in the source dir use that ...
if [ -f ../../source/CAOplugs-source.tar.gz ]; then
  echo "INFO: using sources from the source archive"
  ( cd ../.. ; tar xzf source/CAOplugs-source.tar.gz )
  cd CAOplugs
# ... otherwise get it from git and create a source archive afterwards
else
  git clone https://github.com/caoliver/CAOplugs.git
  cd CAOplugs
  git checkout master
  git submodule update --init --recursive
  ( cd ../../.. ; mkdir -p source ; tar czf source/CAOplugs-source.tar.gz compile/plugins/CAOplugs )
fi
if [ -f ../../../CAOplugs.patch ]; then
  patch -p1 < ../../../CAOplugs.patch
fi
if [ -f ../../../CAOplugs.$MYARCH.patch ]; then
  patch -p1 < ../../../CAOplugs.$MYARCH.patch
fi
cd ..

# go back to a defined starting point to be on the safe side
cd ${WORKDIR}/compile/plugins

# Demo
echo ""
echo "===> Demo extra plugin"
echo ""
# if we have a source archive in the source dir use that ...
if [ -f ../../source/Demo-source.tar.gz ]; then
  echo "INFO: using sources from the source archive"
  ( cd ../.. ; tar xzf source/Demo-source.tar.gz )
  cd Demo
# ... otherwise get it from git and create a source archive afterwards
else
  git clone https://github.com/squinkylabs/Demo.git
  cd Demo
  git checkout main
  git submodule update --init --recursive
  ( cd ../../.. ; mkdir -p source ; tar czf source/Demo-source.tar.gz compile/plugins/Demo )
fi
if [ -f ../../../Demo.patch ]; then
  patch -p1 < ../../../Demo.patch
fi
if [ -f ../../../Demo.$MYARCH.patch ]; then
  patch -p1 < ../../../Demo.$MYARCH.patch
fi
cd ..

# go back to a defined starting point to be on the safe side
cd ${WORKDIR}/compile/plugins

# FM-Delexander
echo ""
echo "===> FM-Delexander extra plugin"
echo ""
# if we have a source archive in the source dir use that ...
if [ -f ../../source/FM-Delexander-source.tar.gz ]; then
  echo "INFO: using sources from the source archive"
  ( cd ../.. ; tar xzf source/FM-Delexander-source.tar.gz )
  cd FM-Delexander
# ... otherwise get it from git and create a source archive afterwards
else
  git clone https://github.com/anlexmatos/FM-Delexander
  cd FM-Delexander
  git checkout master
  git submodule update --init --recursive
  ( cd ../../.. ; mkdir -p source ; tar czf source/FM-Delexander-source.tar.gz compile/plugins/FM-Delexander )
fi
if [ -f ../../../FM-Delexander.patch ]; then
  patch -p1 < ../../../FM-Delexander.patch
fi
if [ -f ../../../FM-Delexander.$MYARCH.patch ]; then
  patch -p1 < ../../../FM-Delexander.$MYARCH.patch
fi
cd ..

# go back to a defined starting point to be on the safe side
cd ${WORKDIR}/compile/plugins

# LocoVCVModules
echo ""
echo "===> LocoVCVModules extra plugin"
echo ""
# if we have a source archive in the source dir use that ...
if [ -f ../../source/LocoVCVModules-source.tar.gz ]; then
  echo "INFO: using sources from the source archive"
  ( cd ../.. ; tar xzf source/LocoVCVModules-source.tar.gz )
  cd LocoVCVModules
# ... otherwise get it from git and create a source archive afterwards
else
  git clone https://github.com/perky/LocoVCVModules.git
  cd LocoVCVModules
  git checkout master
  git submodule update --init --recursive
  ( cd ../../.. ; mkdir -p source ; tar czf source/LocoVCVModules-source.tar.gz compile/plugins/LocoVCVModules )
fi
if [ -f ../../../LocoVCVModules.patch ]; then
  patch -p1 < ../../../LocoVCVModules.patch
fi
if [ -f ../../../LocoVCVModules.$MYARCH.patch ]; then
  patch -p1 < ../../../LocoVCVModules.$MYARCH.patch
fi
cd ..

# go back to a defined starting point to be on the safe side
cd ${WORKDIR}/compile/plugins

# MIDI-Delexander
echo ""
echo "===> MIDI-Delexander extra plugin"
echo ""
# if we have a source archive in the source dir use that ...
if [ -f ../../source/MIDI-Delexander-source.tar.gz ]; then
  echo "INFO: using sources from the source archive"
  ( cd ../.. ; tar xzf source/MIDI-Delexander-source.tar.gz )
  cd MIDI-Delexander
# ... otherwise get it from git and create a source archive afterwards
else
  git clone https://github.com/anlexmatos/MIDI-Delexander.git
  cd MIDI-Delexander
  git checkout master
  git submodule update --init --recursive
  ( cd ../../.. ; mkdir -p source ; tar czf source/MIDI-Delexander-source.tar.gz compile/plugins/MIDI-Delexander )
fi
if [ -f ../../../MIDI-Delexander.patch ]; then
  patch -p1 < ../../../MIDI-Delexander.patch
fi
if [ -f ../../../MIDI-Delexander.$MYARCH.patch ]; then
  patch -p1 < ../../../MIDI-Delexander.$MYARCH.patch
fi
cd ..

# go back to a defined starting point to be on the safe side
cd ${WORKDIR}/compile/plugins

# RackdeLirios
echo ""
echo "===> RackdeLirios extra plugin"
echo ""
# if we have a source archive in the source dir use that ...
if [ -f ../../source/RackdeLirios-source.tar.gz ]; then
  echo "INFO: using sources from the source archive"
  ( cd ../.. ; tar xzf source/RackdeLirios-source.tar.gz )
  cd RackdeLirios
# ... otherwise get it from git and create a source archive afterwards
else
  git clone https://github.com/xnamahx/RackdeLirios.git
  cd RackdeLirios
#  git checkout master
  git checkout 6dfa31e5777be838f34e4ac6d01e0cab1f675b0e
  git submodule update --init --recursive
  ( cd ../../.. ; mkdir -p source ; tar czf source/RackdeLirios-source.tar.gz compile/plugins/RackdeLirios )
fi
if [ -f ../../../RackdeLirios.patch ]; then
  patch -p1 < ../../../RackdeLirios.patch
fi
if [ -f ../../../RackdeLirios.$MYARCH.patch ]; then
  patch -p1 < ../../../RackdeLirios.$MYARCH.patch
fi
cd ..

# go back to a defined starting point to be on the safe side
cd ${WORKDIR}/compile/plugins

# forsitan-modulare
echo ""
echo "===> forsitan-modulare extra plugin"
echo ""
# if we have a source archive in the source dir use that ...
if [ -f ../../source/forsitan-modulare-source.tar.gz ]; then
  echo "INFO: using sources from the source archive"
  ( cd ../.. ; tar xzf source/forsitan-modulare-source.tar.gz )
  cd forsitan-modulare
# ... otherwise get it from git and create a source archive afterwards
else
  git clone https://github.com/gosub/forsitan-modulare.git
  cd forsitan-modulare
  git checkout master
  git submodule update --init --recursive
  ( cd ../../.. ; mkdir -p source ; tar czf source/forsitan-modulare-source.tar.gz compile/plugins/forsitan-modulare )
fi
if [ -f ../../../forsitan-modulare.patch ]; then
  patch -p1 < ../../../forsitan-modulare.patch
fi
if [ -f ../../../forsitan-modulare.$MYARCH.patch ]; then
  patch -p1 < ../../../forsitan-modulare.$MYARCH.patch
fi
cd ..

# go back to a defined starting point to be on the safe side
cd ${WORKDIR}/compile/plugins

# VCVRack_modules
echo ""
echo "===> VCVRack_modules extra plugin"
echo ""
# if we have a source archive in the source dir use that ...
if [ -f ../../source/VCVRack_modules-source.tar.gz ]; then
  echo "INFO: using sources from the source archive"
  ( cd ../.. ; tar xzf source/VCVRack_modules-source.tar.gz )
  cd VCVRack_modules
# ... otherwise get it from git and create a source archive afterwards
else
  git clone https://github.com/gweltou/VCVRack_modules.git
  cd VCVRack_modules
  git checkout master
  git submodule update --init --recursive
  ( cd ../../.. ; mkdir -p source ; tar czf source/VCVRack_modules-source.tar.gz compile/plugins/VCVRack_modules )
fi
if [ -f ../../../VCVRack_modules.patch ]; then
  patch -p1 < ../../../VCVRack_modules.patch
fi
if [ -f ../../../VCVRack_modules.$MYARCH.patch ]; then
  patch -p1 < ../../../VCVRack_modules.$MYARCH.patch
fi
cd ..

# go back to a defined starting point to be on the safe side
cd ${WORKDIR}/compile/plugins

# VCV-Plugins
echo ""
echo "===> VCV-Plugins extra plugin"
echo ""
# if we have a source archive in the source dir use that ...
if [ -f ../../source/VCV-Plugins-source.tar.gz ]; then
  echo "INFO: using sources from the source archive"
  ( cd ../.. ; tar xzf source/VCV-Plugins-source.tar.gz )
  cd VCV-Plugins
# ... otherwise get it from git and create a source archive afterwards
else
  git clone https://github.com/jdstmporter/VCV-Plugins.git
  cd VCV-Plugins
  git checkout master
  git submodule update --init --recursive
  ( cd ../../.. ; mkdir -p source ; tar czf source/VCV-Plugins-source.tar.gz compile/plugins/VCV-Plugins )
fi
if [ -f ../../../VCV-Plugins.patch ]; then
  patch -p1 < ../../../VCV-Plugins.patch
fi
if [ -f ../../../VCV-Plugins.$MYARCH.patch ]; then
  patch -p1 < ../../../VCV-Plugins.$MYARCH.patch
fi
cd ..

# go back to a defined starting point to be on the safe side
cd ${WORKDIR}/compile/plugins

# Paralis-Modular
echo ""
echo "===> Paralis-Modular extra plugin"
echo ""
# if we have a source archive in the source dir use that ...
if [ -f ../../source/Paralis-Modular-source.tar.gz ]; then
  echo "INFO: using sources from the source archive"
  ( cd ../.. ; tar xzf source/Paralis-Modular-source.tar.gz )
  cd Paralis-Modular
# ... otherwise get it from git and create a source archive afterwards
else
  git clone https://github.com/PaeiChe/Paralis-Modular.git
  cd Paralis-Modular
  git checkout master
  git submodule update --init --recursive
  ( cd ../../.. ; mkdir -p source ; tar czf source/Paralis-Modular-source.tar.gz compile/plugins/Paralis-Modular )
fi
if [ -f ../../../Paralis-Modular.patch ]; then
  patch -p1 < ../../../Paralis-Modular.patch
fi
if [ -f ../../../Paralis-Modular.$MYARCH.patch ]; then
  patch -p1 < ../../../Paralis-Modular.$MYARCH.patch
fi
cd ..

# go back to a defined starting point to be on the safe side
cd ${WORKDIR}/compile/plugins

# southpole-vcvrack
echo ""
echo "===> southpole-vcvrack extra plugin"
echo ""
# if we have a source archive in the source dir use that ...
if [ -f ../../source/southpole-vcvrack-source.tar.gz ]; then
  echo "INFO: using sources from the source archive"
  ( cd ../.. ; tar xzf source/southpole-vcvrack-source.tar.gz )
  cd southpole-vcvrack
# ... otherwise get it from git and create a source archive afterwards
else
  git clone https://github.com/dogonthehorizon/southpole-vcvrack
  cd southpole-vcvrack
  git checkout v1
  git submodule update --init --recursive
  ( cd ../../.. ; mkdir -p source ; tar czf source/southpole-vcvrack-source.tar.gz compile/plugins/southpole-vcvrack )
fi
if [ -f ../../../southpole-vcvrack.patch ]; then
  patch -p1 < ../../../southpole-vcvrack.patch
fi
if [ -f ../../../southpole-vcvrack.$MYARCH.patch ]; then
  patch -p1 < ../../../southpole-vcvrack.$MYARCH.patch
fi
cd ..

# go back to a defined starting point to be on the safe side
cd ${WORKDIR}/compile/plugins

# myrisa-modules
echo ""
echo "===> myrisa-modules extra plugin"
echo ""
# if we have a source archive in the source dir use that ...
if [ -f ../../source/myrisa-modules-source.tar.gz ]; then
  echo "INFO: using sources from the source archive"
  ( cd ../.. ; tar xzf source/myrisa-modules-source.tar.gz )
  cd myrisa-modules
# ... otherwise get it from git and create a source archive afterwards
else
  git clone https://github.com/gwatcha/myrisa-modules.git
  cd myrisa-modules
  git checkout master
  git submodule update --init --recursive
  ( cd ../../.. ; mkdir -p source ; tar czf source/myrisa-modules-source.tar.gz compile/plugins/myrisa-modules )
fi
if [ -f ../../../myrisa-modules.patch ]; then
  patch -p1 < ../../../myrisa-modules.patch
fi
if [ -f ../../../myrisa-modules.$MYARCH.patch ]; then
  patch -p1 < ../../../myrisa-modules.$MYARCH.patch
fi
cd ..

# go back to a defined starting point to be on the safe side
cd ${WORKDIR}/compile/plugins

# AtomicHorse-Modules
echo ""
echo "===> AtomicHorse-Modules extra plugin"
echo ""
# if we have a source archive in the source dir use that ...
if [ -f ../../source/AtomicHorse-Modules-source.tar.gz ]; then
  echo "INFO: using sources from the source archive"
  ( cd ../.. ; tar xzf source/AtomicHorse-Modules-source.tar.gz )
  cd AtomicHorse-Modules
# ... otherwise get it from git and create a source archive afterwards
else
  git clone https://github.com/animeslave/AtomicHorse-Modules
  cd AtomicHorse-Modules
  git checkout master
  git submodule update --init --recursive
  ( cd ../../.. ; mkdir -p source ; tar czf source/AtomicHorse-Modules-source.tar.gz compile/plugins/AtomicHorse-Modules )
fi
if [ -f ../../../AtomicHorse-Modules.patch ]; then
  patch -p1 < ../../../AtomicHorse-Modules.patch
fi
if [ -f ../../../AtomicHorse-Modules.$MYARCH.patch ]; then
  patch -p1 < ../../../AtomicHorse-Modules.$MYARCH.patch
fi
cd ..

# go back to a defined starting point to be on the safe side
cd ${WORKDIR}/compile/plugins

# Modal
echo ""
echo "===> Modal extra plugin"
echo ""
# if we have a source archive in the source dir use that ...
if [ -f ../../source/Modal-source.tar.gz ]; then
  echo "INFO: using sources from the source archive"
  ( cd ../.. ; tar xzf source/Modal-source.tar.gz )
  cd Modal
# ... otherwise get it from git and create a source archive afterwards
else
  git clone https://github.com/PelleJuul/Modal
  cd Modal
  git checkout master
  git submodule update --init --recursive
  ( cd ../../.. ; mkdir -p source ; tar czf source/Modal-source.tar.gz compile/plugins/Modal )
fi
if [ -f ../../../Modal.patch ]; then
  patch -p1 < ../../../Modal.patch
fi
if [ -f ../../../Modal.$MYARCH.patch ]; then
  patch -p1 < ../../../Modal.$MYARCH.patch
fi
cd ..

# go back to a defined starting point to be on the safe side
cd ${WORKDIR}/compile/plugins

# Diapason-modules
echo ""
echo "===> Diapason-modules extra plugin"
echo ""
# if we have a source archive in the source dir use that ...
if [ -f ../../source/Diapason-modules-source.tar.gz ]; then
  echo "INFO: using sources from the source archive"
  ( cd ../.. ; tar xzf source/Diapason-modules-source.tar.gz )
  cd Diapason-modules
# ... otherwise get it from git and create a source archive afterwards
else
  git clone https://github.com/gle-bellier/Diapason-modules
  cd Diapason-modules
  git checkout master
  git submodule update --init --recursive
  ( cd ../../.. ; mkdir -p source ; tar czf source/Diapason-modules-source.tar.gz compile/plugins/Diapason-modules )
fi
if [ -f ../../../Diapason-modules.patch ]; then
  patch -p1 < ../../../Diapason-modules.patch
fi
if [ -f ../../../Diapason-modules.$MYARCH.patch ]; then
  patch -p1 < ../../../Diapason-modules.$MYARCH.patch
fi
cd ..

# go back to a defined starting point to be on the safe side
cd ${WORKDIR}/compile/plugins

# Agave
echo ""
echo "===> Agave extra plugin"
echo ""
# if we have a source archive in the source dir use that ...
if [ -f ../../source/Agave-source.tar.gz ]; then
  echo "INFO: using sources from the source archive"
  ( cd ../.. ; tar xzf source/Agave-source.tar.gz )
  cd Agave
# ... otherwise get it from git and create a source archive afterwards
else
  git clone https://github.com/jatinchowdhury18/Agave
  cd Agave
  git checkout master
  git submodule update --init --recursive
  ( cd ../../.. ; mkdir -p source ; tar czf source/Agave-source.tar.gz compile/plugins/Agave )
fi
if [ -f ../../../Agave.patch ]; then
  patch -p1 < ../../../Agave.patch
fi
if [ -f ../../../Agave.$MYARCH.patch ]; then
  patch -p1 < ../../../Agave.$MYARCH.patch
fi
cd ..

# go back to a defined starting point to be on the safe side
cd ${WORKDIR}/compile/plugins

# go back to a defined point
cd ${WORKDIR}

# unpack potential other source archives
cd source
for i in $(ls *.tar.gz | grep -v simde.tar.gz | grep -v Rack-source.tar.gz | grep -v library-source.tar.gz | grep -v Fundamental-source.tar.gz | grep -v VCV-Recorder-source.tar.gz | grep -v vcv-link-source.tar.gz | grep -v LRTRack-source.tar.gz | grep -v vcvrack-packgamma-source.tar.gz | grep -v surge-rack-source.tar.gz); do
  ( cd .. ; tar xzf source/$i )
done

# go back to a defined point
cd ${WORKDIR}
