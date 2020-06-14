FROM agners/archlinuxarm-arm32v7

RUN pacman --noconfirm -Syu
RUN pacman --noconfirm -S base-devel git gdb cmake libx11 glu libxrandr libxinerama libxcursor libxi alsa-lib gtk2 jack2 jq zip wget unzip vim nasm yasm lame vim

# hack to make the ubuntu patches work flawlessly
RUN ln -s /usr/share/automake-1.16 /usr/share/automake-1.15
