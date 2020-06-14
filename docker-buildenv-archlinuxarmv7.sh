#!/bin/bash

WORKDIR=`dirname $0`
cd $WORKDIR

cd docker-archlinuxarmv7
docker build --no-cache -t vcvrack-buildenv-v1-archlinuxarmv7 .
