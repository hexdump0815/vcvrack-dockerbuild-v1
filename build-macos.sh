#!/bin/bash

# exit on errors
set -e

MYWD=`pwd`

cd $MYWD/compile/Rack
make -j2 clean
make -j2 dep
make -j2
cd $MYWD/compile/Fundamental
RACK_DIR=$MYWD/compile/Rack make -j2 clean
RACK_DIR=$MYWD/compile/Rack make -j2 dep
RACK_DIR=$MYWD/compile/Rack make -j2
cd $MYWD/compile/Befaco
RACK_DIR=$MYWD/compile/Rack make -j2 clean
RACK_DIR=$MYWD/compile/Rack make -j2 dep
RACK_DIR=$MYWD/compile/Rack make -j2
