FROM ubuntu:18.04

RUN apt-get update
RUN apt-get -y install build-essential git gdb curl cmake libx11-dev libglu1-mesa-dev libxrandr-dev libxinerama-dev libxcursor-dev libxi-dev zlib1g-dev libasound2-dev libgtk2.0-dev libjack-jackd2-dev jq zip wget unzip vim nasm yasm libmp3lame-dev gcc-8 g++-8 cpp-8

# make gcc 8 the default
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-7 700 --slave /usr/bin/g++ g++ /usr/bin/g++-7 --slave /usr/bin/cpp cpp-bin /usr/bin/cpp-7
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-8 800 --slave /usr/bin/g++ g++ /usr/bin/g++-8 --slave /usr/bin/cpp cpp-bin /usr/bin/cpp-8

