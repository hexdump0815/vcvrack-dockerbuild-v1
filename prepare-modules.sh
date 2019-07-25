#!/bin/bash

# exit on errors
#set -e

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
find * -type f -exec ../../../simde-ify.sh {} \;
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
find * -type f -exec ../../../simde-ify.sh {} \;
# this file gets accidently simde-ified :)
git checkout -- TopographImg.png
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
find * -type f -exec ../../../simde-ify.sh {} \;
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
git checkout release/1.beta1.1
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
find * -type f -exec ../../../simde-ify.sh {} \;
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
git checkout master
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

# Alikins-rack-plugins
echo Alikins-rack-plugins
# this is the version i used this script last with
#git checkout xy
git clone https://github.com/alikins/Alikins-rack-plugins
cd Alikins-rack-plugins
git checkout master
git submodule update --init --recursive
if [ -f ../../../Alikins-rack-plugins.$MYARCH.patch ]; then
  patch -p1 < ../../../Alikins-rack-plugins.$MYARCH.patch
fi
cd ..

# FrozenWasteland
echo FrozenWasteland
# this is the version i used this script last with
#git checkout xy
git clone https://github.com/almostEric/FrozenWasteland
cd FrozenWasteland
git checkout v1
git submodule update --init --recursive
# workaround some compile error by disabling one module on macos
if [ "$MYARCH" = "macos" ]; then
  mv src/PortlandWeather.cpp src/PortlandWeather.cpp.off 
fi
if [ -f ../../../FrozenWasteland.$MYARCH.patch ]; then
  patch -p1 < ../../../FrozenWasteland.$MYARCH.patch
fi
cd ..

# BaconPlugs
echo BaconPlugs
# this is the version i used this script last with
#git checkout xy
git clone https://github.com/baconpaul/BaconPlugs
cd BaconPlugs
git checkout master
git submodule update --init --recursive
if [ -f ../../../BaconPlugs.$MYARCH.patch ]; then
  patch -p1 < ../../../BaconPlugs.$MYARCH.patch
fi
cd ..

# catro-modulo
echo catro-modulo
# this is the version i used this script last with
#git checkout xy
git clone https://github.com/catronomix/catro-modulo
cd catro-modulo
git checkout master
git submodule update --init --recursive
if [ -f ../../../catro-modulo.$MYARCH.patch ]; then
  patch -p1 < ../../../catro-modulo.$MYARCH.patch
fi
cd ..

# modules chortlinghamster
echo modules chortlinghamster
# this is the version i used this script last with
#git checkout xy
git clone https://github.com/chortlinghamster/modules
cd modules
git checkout master
git submodule update --init --recursive
if [ -f ../../../modules.$MYARCH.patch ]; then
  patch -p1 < ../../../modules.$MYARCH.patch
fi
cd ..

# Bark
echo Bark
# this is the version i used this script last with
#git checkout xy
git clone https://github.com/Coirt/Bark
cd Bark
git checkout master
git submodule update --init --recursive
if [ -f ../../../Bark.$MYARCH.patch ]; then
  patch -p1 < ../../../Bark.$MYARCH.patch
fi
cd ..

# VCVRackPlugins countmodula
echo VCVRackPlugins countmodula
# this is the version i used this script last with
#git checkout xy
git clone https://github.com/countmodula/VCVRackPlugins
cd VCVRackPlugins
git checkout V1
git submodule update --init --recursive
if [ -f ../../../VCVRackPlugins.$MYARCH.patch ]; then
  patch -p1 < ../../../VCVRackPlugins.$MYARCH.patch
fi
cd ..

# modular80
echo modular80
# this is the version i used this script last with
#git checkout xy
git clone https://github.com/cschol/modular80
cd modular80
git checkout v1
git submodule update --init --recursive
if [ -f ../../../modular80.$MYARCH.patch ]; then
  patch -p1 < ../../../modular80.$MYARCH.patch
fi
cd ..

# ModularFungi
echo ModularFungi
# this is the version i used this script last with
#git checkout xy
git clone https://github.com/david-c14/ModularFungi
cd ModularFungi
git checkout master
git submodule update --init --recursive
if [ -f ../../../ModularFungi.$MYARCH.patch ]; then
  patch -p1 < ../../../ModularFungi.$MYARCH.patch
fi
cd ..

# dBiz
echo dBiz
# this is the version i used this script last with
#git checkout xy
git clone https://github.com/dBiz/dBiz
cd dBiz
git checkout master
git submodule update --init --recursive
if [ -f ../../../dBiz.$MYARCH.patch ]; then
  patch -p1 < ../../../dBiz.$MYARCH.patch
fi
cd ..

# DHE-Modules
echo DHE-Modules
# this is the version i used this script last with
#git checkout xy
git clone https://github.com/dhemery/DHE-Modules
cd DHE-Modules
git checkout master
git submodule update --init --recursive
if [ -f ../../../DHE-Modules.$MYARCH.patch ]; then
  patch -p1 < ../../../DHE-Modules.$MYARCH.patch
fi
cd ..

# moDllz
echo moDllz
# this is the version i used this script last with
#git checkout xy
git clone https://github.com/dllmusic/moDllz
cd moDllz
git checkout master
git submodule update --init --recursive
if [ -f ../../../moDllz.$MYARCH.patch ]; then
  patch -p1 < ../../../moDllz.$MYARCH.patch
fi
cd ..

# Ohmer-Modules
echo Ohmer-Modules
# this is the version i used this script last with
#git checkout xy
git clone https://github.com/DomiKamu/Ohmer-Modules
cd Ohmer-Modules
git checkout master
git submodule update --init --recursive
if [ -f ../../../Ohmer-Modules.$MYARCH.patch ]; then
  patch -p1 < ../../../Ohmer-Modules.$MYARCH.patch
fi
cd ..

# vcvrack-encoders
echo vcvrack-encoders
# this is the version i used this script last with
#git checkout xy
git clone https://github.com/expertsleepersltd/vcvrack-encoders
cd vcvrack-encoders
git checkout master
git submodule update --init --recursive
if [ -f ../../../vcvrack-encoders.$MYARCH.patch ]; then
  patch -p1 < ../../../vcvrack-encoders.$MYARCH.patch
fi
cd ..

# FrankBussRackPlugin
echo FrankBussRackPlugin
# this is the version i used this script last with
#git checkout xy
git clone https://github.com/FrankBuss/FrankBussRackPlugin
cd FrankBussRackPlugin
git checkout master
git submodule update --init --recursive
if [ -f ../../../FrankBussRackPlugin.$MYARCH.patch ]; then
  patch -p1 < ../../../FrankBussRackPlugin.$MYARCH.patch
fi
cd ..

# VCVRack-Holon.ist
echo VCVRack-Holon.ist
# this is the version i used this script last with
#git checkout xy
git clone https://github.com/hdavid/VCVRack-Holon.ist
cd VCVRack-Holon.ist
git checkout v1
git submodule update --init --recursive
if [ -f ../../../VCVRack-Holon.ist.$MYARCH.patch ]; then
  patch -p1 < ../../../VCVRack-Holon.ist.$MYARCH.patch
fi
cd ..

# AmalgamatedHarmonics
echo AmalgamatedHarmonics
# this is the version i used this script last with
#git checkout xy
git clone https://github.com/jhoar/AmalgamatedHarmonics
cd AmalgamatedHarmonics
git checkout master
git submodule update --init --recursive
if [ -f ../../../AmalgamatedHarmonics.$MYARCH.patch ]; then
  patch -p1 < ../../../AmalgamatedHarmonics.$MYARCH.patch
fi
cd ..

# vcv-karatesnoopy
echo vcv-karatesnoopy
# this is the version i used this script last with
#git checkout xy
git clone https://github.com/KarateSnoopy/vcv-karatesnoopy
cd vcv-karatesnoopy
git checkout v1
git submodule update --init --recursive
if [ -f ../../../vcv-karatesnoopy.$MYARCH.patch ]; then
  patch -p1 < ../../../vcv-karatesnoopy.$MYARCH.patch
fi
cd ..

# Koralfx-Modules
echo Koralfx-Modules
# this is the version i used this script last with
#git checkout xy
git clone https://github.com/koralfx/Koralfx-Modules
cd Koralfx-Modules
git checkout master
git submodule update --init --recursive
if [ -f ../../../Koralfx-Modules.$MYARCH.patch ]; then
  patch -p1 < ../../../Koralfx-Modules.$MYARCH.patch
fi
cd ..

# WhatTheRack
echo WhatTheRack
# this is the version i used this script last with
#git checkout xy
git clone https://github.com/korfuri/WhatTheRack
cd WhatTheRack
git checkout v1
git submodule update --init --recursive
if [ -f ../../../WhatTheRack.$MYARCH.patch ]; then
  patch -p1 < ../../../WhatTheRack.$MYARCH.patch
fi
cd ..

# hetrickcv
echo hetrickcv
# this is the version i used this script last with
#git checkout xy
git clone https://github.com/mhetrick/hetrickcv
cd hetrickcv
git checkout v1
git submodule update --init --recursive
if [ -f ../../../hetrickcv.$MYARCH.patch ]; then
  patch -p1 < ../../../hetrickcv.$MYARCH.patch
fi
cd ..

# strong_kar
echo strong_kar
# this is the version i used this script last with
#git checkout xy
git clone https://github.com/mrletourneau/strong_kar
cd strong_kar
git checkout v1.1.0
git submodule update --init --recursive
if [ -f ../../../strong_kar.$MYARCH.patch ]; then
  patch -p1 < ../../../strong_kar.$MYARCH.patch
fi
cd ..

# VCV-Rack-Plugins
echo VCV-Rack-Plugins
# this is the version i used this script last with
#git checkout xy
git clone https://github.com/mschack/VCV-Rack-Plugins
cd VCV-Rack-Plugins
git checkout master
git submodule update --init --recursive
if [ -f ../../../VCV-Rack-Plugins.$MYARCH.patch ]; then
  patch -p1 < ../../../VCV-Rack-Plugins.$MYARCH.patch
fi
cd ..

# noobhour_modules
echo noobhour_modules
# this is the version i used this script last with
#git checkout xy
git clone https://github.com/NicolasNeubauer/noobhour_modules
cd noobhour_modules
git checkout master
git submodule update --init --recursive
if [ -f ../../../noobhour_modules.$MYARCH.patch ]; then
  patch -p1 < ../../../noobhour_modules.$MYARCH.patch
fi
cd ..

# rcm-modules
echo rcm-modules
# this is the version i used this script last with
#git checkout xy
git clone https://github.com/Rcomian/rcm-modules
cd rcm-modules
git checkout v1
git submodule update --init --recursive
if [ -f ../../../rcm-modules.$MYARCH.patch ]; then
  patch -p1 < ../../../rcm-modules.$MYARCH.patch
fi
cd ..

# vcv-mosquito
echo vcv-mosquito
# this is the version i used this script last with
#git checkout xy
git clone https://github.com/rmosquito/vcv-mosquito
cd vcv-mosquito
git checkout master
git submodule update --init --recursive
if [ -f ../../../vcv-mosquito.$MYARCH.patch ]; then
  patch -p1 < ../../../vcv-mosquito.$MYARCH.patch
fi
cd ..

# skylights-vcv
echo skylights-vcv
# this is the version i used this script last with
#git checkout xy
git clone https://github.com/Skrylar/skylights-vcv
cd skylights-vcv
git checkout master
git submodule update --init --recursive
if [ -f ../../../skylights-vcv.$MYARCH.patch ]; then
  patch -p1 < ../../../skylights-vcv.$MYARCH.patch
fi
cd ..

# Via-for-Rack
echo Via-for-Rack
# this is the version i used this script last with
#git checkout xy
git clone https://github.com/starlingcode/Via-for-Rack
cd Via-for-Rack
git checkout v1
git submodule update --init --recursive
if [ -f ../../../Via-for-Rack.$MYARCH.patch ]; then
  patch -p1 < ../../../Via-for-Rack.$MYARCH.patch
fi
cd ..

# vcvrack-packone
echo vcvrack-packone
# this is the version i used this script last with
#git checkout xy
git clone https://github.com/stoermelder/vcvrack-packone
cd vcvrack-packone
git checkout v1
git submodule update --init --recursive
if [ -f ../../../vcvrack-packone.$MYARCH.patch ]; then
  patch -p1 < ../../../vcvrack-packone.$MYARCH.patch
fi
cd ..

# quantal-audio
echo quantal-audio
# this is the version i used this script last with
#git checkout xy
git clone https://github.com/sumpygump/quantal-audio
cd quantal-audio
git checkout master
git submodule update --init --recursive
if [ -f ../../../quantal-audio.$MYARCH.patch ]; then
  patch -p1 < ../../../quantal-audio.$MYARCH.patch
fi
cd ..

# VCV-Recorder
echo VCV-Recorder
# this is the version i used this script last with
#git checkout xy
git clone https://github.com/VCVRack/VCV-Recorder
cd VCV-Recorder
git checkout v1
git submodule update --init --recursive
if [ -f ../../../VCV-Recorder.$MYARCH.patch ]; then
  patch -p1 < ../../../VCV-Recorder.$MYARCH.patch
fi
cd ..

# sonusmodular
echo sonusmodular
# this is the version i used this script last with
#git checkout xy
git clone https://gitlab.com/sonusdept/sonusmodular
cd sonusmodular
git checkout master
git submodule update --init --recursive
if [ -f ../../../sonusmodular.$MYARCH.patch ]; then
  patch -p1 < ../../../sonusmodular.$MYARCH.patch
fi
cd ..

# # 21kHz-rack-plugins - alternative v1 port with polyphony
# echo 21kHz-rack-plugins
# # this is the version i used this script last with
# #git checkout xy
# git clone https://github.com/stephanepericat/21kHz-rack-plugins
# cd 21kHz-rack-plugins
# git checkout v1
# git submodule update --init --recursive
# if [ -f ../../../21kHz-rack-plugins.$MYARCH.patch ]; then
#   patch -p1 < ../../../21kHz-rack-plugins.$MYARCH.patch
# fi
# cd ..

# 21kHz-rack-plugins - my started v1 port
echo 21kHz-rack-plugins
# this is the version i used this script last with
#git checkout xy
git clone https://github.com/hexdump0815/21kHz-rack-plugins
cd 21kHz-rack-plugins
git checkout v1
git submodule update --init --recursive
if [ -f ../../../21kHz-rack-plugins.$MYARCH.patch ]; then
  patch -p1 < ../../../21kHz-rack-plugins.$MYARCH.patch
fi
cd ..

# Bidoo
echo Bidoo
# this is the version i used this script last with
#git checkout xy
git clone https://github.com/sebastien-bouffier/Bidoo
cd Bidoo
git checkout v1.0
git submodule update --init --recursive
# workaround some compile errors by disabling some modules on macos
if [ "$MYARCH" = "macos" ]; then
  mv src/CANARD.cpp src/CANARD.cpp.off
  mv src/LIMONADE.cpp src/LIMONADE.cpp.off
  mv src/OUAIVE.cpp src/OUAIVE.cpp.off
fi
if [ -f ../../../Bidoo.$MYARCH.patch ]; then
  patch -p1 < ../../../Bidoo.$MYARCH.patch
fi
cd ..

# Prism
echo Prism
# this is the version i used this script last with
#git checkout xy
git clone https://github.com/AmalgamatedHarmonics/Prism
cd Prism
git checkout master
git submodule update --init --recursive
if [ -f ../../../Prism.$MYARCH.patch ]; then
  patch -p1 < ../../../Prism.$MYARCH.patch
fi
cd ..

# RackModules
echo RackModules
# this is the version i used this script last with
#git checkout xy
git clone https://github.com/AnimatedCircuits/RackModules
cd RackModules
git checkout master
git submodule update --init --recursive
if [ -f ../../../RackModules.$MYARCH.patch ]; then
  patch -p1 < ../../../RackModules.$MYARCH.patch
fi
cd ..

# Ahornberg-Microtonal
echo Ahornberg-Microtonal
# this is the version i used this script last with
#git checkout xy
git clone https://github.com/Coirt/Ahornberg-Microtonal
cd Ahornberg-Microtonal
git checkout master
git submodule update --init --recursive
if [ -f ../../../Ahornberg-Microtonal.$MYARCH.patch ]; then
  patch -p1 < ../../../Ahornberg-Microtonal.$MYARCH.patch
fi
cd ..

# MyLittleTools
echo MyLittleTools
# this is the version i used this script last with
#git checkout xy
git clone https://github.com/digitalhappens/MyLittleTools
cd MyLittleTools
git checkout master
git submodule update --init --recursive
if [ -f ../../../MyLittleTools.$MYARCH.patch ]; then
  patch -p1 < ../../../MyLittleTools.$MYARCH.patch
fi
cd ..

# MicMusic-VCV
echo MicMusic-VCV
# this is the version i used this script last with
#git checkout xy
git clone https://github.com/very-cool-name/MicMusic-VCV
cd MicMusic-VCV
git checkout master
git submodule update --init --recursive
if [ -f ../../../MicMusic-VCV.$MYARCH.patch ]; then
  patch -p1 < ../../../MicMusic-VCV.$MYARCH.patch
fi
cd ..

# ZZC
echo ZZC
# this is the version i used this script last with
#git checkout xy
git clone https://github.com/zezic/ZZC
cd ZZC
git checkout master
git submodule update --init --recursive
if [ -f ../../../ZZC.$MYARCH.patch ]; then
  patch -p1 < ../../../ZZC.$MYARCH.patch
fi
cd ..

# skjack-vcv
echo skjack-vcv
# this is the version i used this script last with
#git checkout xy
git clone https://github.com/Skrylar/skjack-vcv
cd skjack-vcv
git checkout master
git submodule update --init --recursive
if [ -f ../../../skjack-vcv.$MYARCH.patch ]; then
  patch -p1 < ../../../skjack-vcv.$MYARCH.patch
fi
cd ..

# SubmarineFree
echo SubmarineFree
# this is the version i used this script last with
#git checkout xy
git clone https://github.com/david-c14/SubmarineFree
cd SubmarineFree
git checkout master
git submodule update --init --recursive
if [ -f ../../../SubmarineFree.$MYARCH.patch ]; then
  patch -p1 < ../../../SubmarineFree.$MYARCH.patch
fi
cd ..

# Circlefade
echo Circlefade
# this is the version i used this script last with
#git checkout xy
git clone https://github.com/max-circlefade/Circlefade
cd Circlefade
git checkout master
git submodule update --init --recursive
if [ -f ../../../Circlefade.$MYARCH.patch ]; then
  patch -p1 < ../../../Circlefade.$MYARCH.patch
fi
cd ..

# SLM-vcv-rack
echo SLM-vcv-rack
# this is the version i used this script last with
#git checkout xy
git clone https://github.com/salvolm84/SLM-vcv-rack
cd SLM-vcv-rack
git checkout master
git submodule update --init --recursive
if [ -f ../../../SLM-vcv-rack.$MYARCH.patch ]; then
  patch -p1 < ../../../SLM-vcv-rack.$MYARCH.patch
fi
cd ..

# RJModules
echo RJModules
# this is the version i used this script last with
#git checkout xy
git clone http://github.com/Miserlou/RJModules
cd RJModules
git checkout master
git submodule update --init --recursive
if [ -f ../../../RJModules.$MYARCH.patch ]; then
  patch -p1 < ../../../RJModules.$MYARCH.patch
fi
cd ..

# computerscare-vcv-modules
echo computerscare-vcv-modules
# this is the version i used this script last with
#git checkout xy
git clone https://github.com/freddyz/computerscare-vcv-modules
cd computerscare-vcv-modules
git checkout master
git submodule update --init --recursive
if [ -f ../../../computerscare-vcv-modules.$MYARCH.patch ]; then
  patch -p1 < ../../../computerscare-vcv-modules.$MYARCH.patch
fi
cd ..

# LomasModules
echo LomasModules
# this is the version i used this script last with
#git checkout xy
git clone https://github.com/LomasModules/LomasModules
cd LomasModules
git checkout master
git submodule update --init --recursive
if [ -f ../../../LomasModules.$MYARCH.patch ]; then
  patch -p1 < ../../../LomasModules.$MYARCH.patch
fi
cd ..

# repelzen
echo repelzen
# this is the version i used this script last with
#git checkout xy
git clone https://github.com/wiqid/repelzen
cd repelzen
git checkout master
git submodule update --init --recursive
if [ -f ../../../repelzen.$MYARCH.patch ]; then
  patch -p1 < ../../../repelzen.$MYARCH.patch
fi
cd ..
