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
  cp windows-run-rack.bat dist/run-rack.bat
  if [ "$MYARCH" = "win64" ]; then
    cp /mingw64/bin/libwinpthread-1.dll /mingw64/bin/libstdc++-6.dll /mingw64/bin/libgcc_s_seh-1.dll dist
  else
    cp /mingw32/bin/libwinpthread-1.dll /mingw32/bin/libstdc++-6.dll /mingw32/bin/libgcc_s_dw2-1.dll dist
  fi
else
  cp compile/Rack/Rack dist
fi
( cd dist/plugins ; for i in ../../compile/library/repos/*/dist/*-${ZIPNAME}.zip ; do unzip $i ; done )
( cd dist/plugins ; for i in ../../compile/plugins/*/dist/*-${ZIPNAME}.zip ; do unzip $i ; done )

# the skjack plugin is partial broken and not recommended, so move it away
if [ -d dist/plugins/SkJack ]; then
  mkdir -p dist/plugins.off
  mv dist/plugins/SkJack dist/plugins.off
fi

mkdir -p dist/rack-sdk/dep
for i in *.mk helper.py include LICENSE-dist.txt LICENSE-GPLv3.txt LICENSE.md; do
  cp -r compile/Rack/$i dist/rack-sdk
done

cp -r compile/Rack/dep/include dist/rack-sdk/dep

if [ "$MYOS" = "Msys" ]; then
  cp compile/Rack/libRack.a dist/rack-sdk
fi
