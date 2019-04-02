#!/bin/bash

mkdir -p dist/plugins
for i in CHANGELOG.md LICENSE-dist.txt LICENSE.md Rack res template.vcv; do  cp -r compile/Rack/$i dist; done
cp -r compile/Fundamental dist/plugins
cp -r compile/Befaco dist/plugins
rm -rf dist/plugins/*/src dist/plugins/*/dep dist/plugins/*/build dist/plugins/*/Makefile dist/plugins/*/README.md
strip -S dist/Rack dist/plugins/*/plugin.so
