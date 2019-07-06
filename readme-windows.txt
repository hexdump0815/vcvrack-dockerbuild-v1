for building the windows versions follow the preparations from https://vcvrack.com/manual/Building.html

afterwards run

  pacman -Su nasm yasm patch vim openssh

the build process on windows does not use docker - the order of things to do thus is:

./prepare.sh
./compile/build.sh
./prepare-modules.sh
./compile/build-modules.sh
./make-dist.sh

windows 32bit: the DHE-Modules, Befaco, Drumkit and Surge for Rack modules do not compile right now for me on windows in 32bit mode
windows 64bit: the DHE-Modules module do not compile right now for me on windows in 64bit mode

i'm doing my builds on a windows 64bit system using the included msys2 64bit shell for the 64bit build and the msys2 32bit shell for the 32bit build.
