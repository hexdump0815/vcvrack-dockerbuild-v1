FROM debian:buster

RUN apt-get update
RUN apt-get -y install build-essential git gdb curl cmake libx11-dev libglu1-mesa-dev libxrandr-dev libxinerama-dev libxcursor-dev libxi-dev zlib1g-dev libasound2-dev libgtk2.0-dev libjack-jackd2-dev jq zip wget unzip vim libstdc++-7-dev libavcodec-dev

# hack to make the ubuntu patches work flawlessly
RUN ln -s /usr/share/automake-1.16 /usr/share/automake-1.15
