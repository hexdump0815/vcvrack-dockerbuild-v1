#!/bin/bash

WORKDIR=`dirname $0`
cd $WORKDIR
WORKDIR=`pwd`

MYARCH=`uname -m`
MYUNAME=`uname`

export ZIPNAME="lin"
if [ "$MYUNAME" = "Darwin" ]; then
  MYARCH="macos"
  export ZIPNAME="mac"
else
  MYOS=`uname -o`
  if [ "$MYOS" = "Msys" ]; then
    if [ "$MSYSTEM_CARCH" = "x86_64" ]; then
      MYARCH="win64"
      export ZIPNAME="win"
    else
      MYARCH="win32"
      export ZIPNAME="win"
    fi
  fi
fi

mkdir -p dist/plugins
for i in CHANGELOG.md LICENSE-dist.txt LICENSE.md res template.vcv Core.json; do  cp -r compile/Rack/$i dist; done
if [ -f compile/Rack/Rack.exe ]; then
  cp compile/Rack/Rack.exe dist
else
  cp compile/Rack/Rack dist
fi
( cd dist/plugins ; for i in ../../compile/plugins/*/dist/*-${ZIPNAME}.zip ; do unzip $i ; done )
