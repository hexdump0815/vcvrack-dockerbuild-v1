#!/bin/bash

# exit on errors
set -e

cd /compile/Rack
make -j2 clean
make -j2 dep
make -j2
cd ../Fundamental
RACK_DIR=/compile/Rack make -j2 clean
RACK_DIR=/compile/Rack make -j2 dep
RACK_DIR=/compile/Rack make -j2
cd ../Befaco
RACK_DIR=/compile/Rack make -j2 clean
RACK_DIR=/compile/Rack make -j2 dep
RACK_DIR=/compile/Rack make -j2
