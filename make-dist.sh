#!/bin/bash

WORKDIR=`dirname $0`
cd $WORKDIR

mkdir -p dist/plugins
for i in CHANGELOG.md LICENSE-dist.txt LICENSE.md Rack res template.vcv Core.json; do  cp -r compile/Rack/$i dist; done
( cd dist/plugins ; for i in ../../compile/plugins/*/dist/*-lin.zip ; do unzip $i ; done )
# do not strip the debug info out yet - makes debugging easier
#strip -S dist/Rack dist/plugins/*/plugin.so
