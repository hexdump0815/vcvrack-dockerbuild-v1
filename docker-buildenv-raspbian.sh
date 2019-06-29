#!/bin/bash

WORKDIR=`dirname $0`
cd $WORKDIR

mkdir -p ${WORKDIR}/root
debootstrap --variant=minbase --arch=armhf --no-check-gpg buster ${WORKDIR}/root http://archive.raspbian.org/raspbian
tar -C ${WORKDIR}/root -c . | docker import - raspbian-buster

cd docker-raspbian
docker build --no-cache -t vcvrack-buildenv-v1-raspbian .
