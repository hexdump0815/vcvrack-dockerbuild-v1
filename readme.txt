vcvrack dockerbuild for the v1 development version
==================================================

this is my dockerbuild setup to easily build vcvrack (v0.6.2c and the current v1 development version) on intel and arm in both 32bit and 64bit versions - all that on ubuntu 18.04 (and intel 64bit macos too). it contains all the patches i used to get it built especially on arm (for instance using the simde project to translate the sse code to arm neon code as good as possible in a semiautomatic way). if you have the vst and au sdk's then you can put them in vst-sdk and au-sdk directories like shown in the corresponding readme files. i can't put them here for licensing reasons. without them the vst and au (on macos) plugins cannot and will not be built. for building this you should have at least 2gb of ram (it works with 1gb ram on an arm board, but it will swap like crazy and is not really recommended - better use an arm machine with 2gb of ram like an odroid c2, odroid xu4, asus tinkerboard etc.) - all builds are assumed to be done native (cross compiling would require some changes on the scripts).

regarding running vcvrack on arm don't get too excited: the performance of the usual arm sbc boards is way lower than the performance of a contemporary or older intel machine, but anyway with some optimizations and watching out for well performing plugins in vcvrack it is possible with small to medium sized patches. quite a bit of audio tuning is required and one should use a sampling frequency of 32khz preferrably, as this saves quite a few cpu cycles compared to 44.1khz or higher and still gives good quality sound. the biggest problem though is finding properly working opengl on those arm boards - it is often slow, broken or non existent and it took me quite some effort, tuning and patchig to get it working.

my reference systems are:
* orbsmart s92 tv box - rockchip rk3288 4x1.5ghz 2gb ram - running ubuntu 18.04 armv7l with a self compiled linux 4.19.32 kernel with mali and other patches (it is similar to an asus tinkerboard) - usb audio PCM2704 (from ebay)
* a95xr2 tv box - amlogic s905w 4x1.2ghz 2gb ram - running ubuntu 18.04 aarch64 with a self compiled linux 4.19.32 kernel with mali and other patches (it is similar but a bit slower than an odroid c2, khadas vim or libreteck potato board) - usb audio PCM2704 (from ebay)
* raspberry pi 3b - broadcom soc 4x1.2ghz 1gb ram - running ubuntu 18.04 aarch64 (not 32bit raspbian!) with a self compiled linux 5.0.5 kernel and self compiled latest mesa vc4 (i would not really recommend using a raspberry pi for this except you already have one around - better get an odroid c2 for instance, which has better performance, excellent linux mainline support and a much better hardware design) - native headphone jack audio

all this is not really useable beyond experimenting around right now. my plan is to run it in headless mode at some point using xvfb and xpra and thus create a little box to which i can connect a midi controller and play it like an instrument based on a fixed patch with a lot of midi-cc preconfigured. right now it is even possible to use those systems interactively with monitor, keyboard and mouse attached (with a lot of audio and opengl tuning and patching of course), but do not expect wonders ... :)

compiled binary packages for all the mentioned architectures are available under releases

some thanks to:
- andrew belt for starting and keeping vcvrack up - https://github.com/VCVRack/Rack
- jim t (rcomian) for his improved fork of the 0.6 vcvrack - https://github.com/Rcomian/Rack
- pronvit for bringing me to the idea to even try to run vcvrack on arm - https://github.com/mi-rack/Rack
- evan nemerson for his wonderful simde project, which makes it possible to somehow translate the intel sse code to arm neon with a limited effort - https://github.com/nemequ/simde
- and to all the others involved in vcvrack, its plugins, its community and people involved in the opensource community making things like this possible

watch out for updates - there should be some coming during the next weeks and months ...


order of thingsi to build:

linux:

requirement: docker installed and running, tested on ubuntu 18.04

docker-buildenv.sh
prepare.sh
buildenv.sh

then inside of the docker container:

/compile/build.sh

macos:

requirement: brew installed and working, tested on macos 10.12.6

prepare-macos-brew.sh
prepare.sh
prepare-macos-additional.sh
buld-macos.sh
make-dist.sh

running rack: the dist folder can be copied anywhere, run ./Rack -d inside of it, some working opengl is required otherwise software rendering will eat up too much cpu cycles ...
