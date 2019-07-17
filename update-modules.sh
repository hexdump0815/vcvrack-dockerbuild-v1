#!/bin/bash

# exit on errors
#set -e

WORKDIR=`dirname $0`
cd $WORKDIR
WORKDIR=`pwd`

cd compile/plugins
for i in * ; do
  echo ""
  echo "=== $i ==="
  echo ""
  cd $i
  git pull
  cd ..
done
cd ../..
