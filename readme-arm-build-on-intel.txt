in case you want to build the arm versions on an intel machine the following should work (assuming ubuntu 18.04 on x86_64 (64bit) linux with working docker installation) - just roughly tested, but should work ... as it is emulating the arm cpu in software on intel it will be way slower than building natively on arm

- install qemu-user-static to do the cpu translation in software for arm 32bit and 64bit

apt-get install qemu-arm-static qemu-aarch64-static

- do the prepare steps a usual

./prepare.sh
./prepare-modules.sh

- for armv7l: open an armv7l ubuntu container

docker run -v /usr/bin/qemu-arm-static:/usr/bin/qemu-arm-static -v `pwd`/compile:/compile --rm -ti arm32v7/ubuntu:18.04

- for aarch64: open an aarch64 ubuntu container

docker run -v /usr/bin/qemu-aarch64-static:/usr/bin/qemu-aarch64-static -v `pwd`/compile:/compile --rm -ti arm64v8/ubuntu:18.04

- for raspbian buster: create and open an raspbian buster container

WORKDIR=`pwd`
mkdir -p ${WORKDIR}/root
debootstrap --variant=minbase --arch=armhf --no-check-gpg buster ${WORKDIR}/root http://archive.raspbian.org/raspbian
tar -C ${WORKDIR}/root -c . | docker import - raspbian-buster
docker run -v /usr/bin/qemu-arm-static:/usr/bin/qemu-arm-static -v `pwd`/compile:/compile --rm -ti raspbian-buster /bin/bash

- then inside run the commands from docker/Dockerfile (example)

apt-get update
apt-get -y install build-essential git gdb curl cmake libx11-dev libglu1-mesa-dev libxrandr-dev libxinerama-dev libxcursor-dev libxi-dev zlib1g-dev libasound2-dev libgtk2.0-dev libjack-jackd2-dev jq zip wget unzip vim nasm yasm libmp3lame-dev

- the build as usual

/compile/build.sh
/compile/build-modules.sh

- exit the container and build the distribution

./make-dist.sh
