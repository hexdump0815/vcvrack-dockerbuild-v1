#!/bin/bash

WORKDIR=`dirname $0`
cd $WORKDIR

cd docker-archlinuxarmv8
docker build --no-cache -t vcvrack-buildenv-v1-archlinuxarmv8 .
