#!/bin/bash

WORKDIR=`dirname $0`
cd $WORKDIR

MYUNAME=`uname`
if [ "$MYUNAME" != "Darwin" ]; then
  MYOS=`uname -o`
fi

mkdir -p dist/rack-sdk/dep
for i in *.mk helper.py include LICENSE-dist.txt LICENSE-GPLv3.txt LICENSE.md; do
  cp -r compile/Rack/$i dist/rack-sdk
done

cp -r compile/Rack/dep/include dist/rack-sdk/dep

if [ "$MYOS" = "Msys" ]; then
  cp libRack.a dist/rack-sdk
fi
