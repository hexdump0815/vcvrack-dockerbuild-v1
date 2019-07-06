## vcvrack dockerbuild for the v1 development version

this is my dockerbuild setup to easily build vcvrack v1 arm in both 32bit and 64bit versions - all that on ubuntu 18.04 and raspbian buster. it contains all the patches i used to get it built especially on arm (for instance using the simde project to translate the sse code to arm neon code as good as possible in a semiautomatic way).

planned for version 1.1.0: if you have the vst and au sdk's then you can put them in vst-sdk and au-sdk directories like shown in the corresponding readme files. i can't put them here for licensing reasons. without them the vst plugins cannot and will not be built.

for building this you should have at least 2gb of ram (it works with 1gb ram on an arm board, but it will swap like crazy and is not really recommended - better use an arm machine with 2gb of ram like an odroid c2, odroid xu4, asus tinkerboard etc.) - all builds are assumed to be done native (cross compiling would require some changes on the scripts).

regarding running vcvrack on arm don't get too excited: the performance of the usual arm sbc boards is way lower than the performance of a contemporary or older intel machine, but anyway with some optimizations and watching out for well performing plugins in vcvrack it is possible with small to medium sized patches. quite a bit of audio tuning is required and one should use a sampling frequency of 32khz preferrably, as this saves quite a few cpu cycles compared to 44.1khz or higher and still gives good quality sound. the biggest problem though is finding properly working opengl on those arm boards - it is often slow, broken or non existent and it took me quite some effort, tuning and patchig to get it working.

my reference systems are:
* orbsmart s92 tv box - rockchip rk3288 4x1.5ghz 2gb ram - running ubuntu 18.04 armv7l with a self compiled linux 5.1.5 kernel with mali and other patches (it is similar to an asus tinkerboard) - usb audio PCM2704 (from ebay)
* a95xr2 tv box - amlogic s905w 4x1.2ghz 2gb ram - running ubuntu 18.04 aarch64 with a self compiled linux 5.1.5 kernel with mali and other patches (it is similar but a bit slower than an odroid c2, khadas vim or libreteck potato board) - usb audio PCM2704 (from ebay)
* raspberry pi 3b - broadcom soc 4x1.2ghz 1gb ram - running ubuntu 18.04 aarch64 (not 32bit raspbian!) with a self compiled linux 5.0.20 kernel and self compiled latest mesa vc4 - native headphone jack audio

compiled binary packages for all the mentioned architectures are available under releases

some thanks to:
- andrew belt for starting and keeping vcvrack up - https://github.com/VCVRack/Rack
- pronvit for bringing me to the idea to even try to run vcvrack on arm - https://github.com/mi-rack/Rack
- evan nemerson for his wonderful simde project, which makes it possible to somehow translate the intel sse code to arm neon with a limited effort - https://github.com/nemequ/simde
- and to all the others involved in vcvrack, its plugins, its community and people involved in the opensource community making things like this possible

watch out for updates - there should be some coming during the next weeks and months ...


# order of things to build all this:

requirement: docker installed and running, tested on ubuntu 18.04

docker-buildenv.sh (docker-buildenv-raspbian.sh)
prepare.sh
prepare-modules.sh
buildenv.sh (buildenv-raspbian.sh)

then inside of the docker container:

/compile/build.sh
/compile/build-modules.sh

then back outside of the docker container to create a dist folder with everything in it:

make-dist.sh

# running rack

the dist folder can be copied anywhere, run ./Rack -d inside of it, some working opengl is required otherwise software rendering will eat up too much cpu cycles ... it is recommended to use jack for audio

IMPORTANT: in case you run into problems with those builds here, please create an issue in this git repo and not in the vcvrack repo, as the problems might be related to this build and not to vcvrack in general

# changelog

version 1.1.0 (planned, not yet released)
- upgraded vcvrack to version v1.1.0
- more included plugins (all 51 currently available open source plugins plus 21khz, bidoo and lindenberg research - resulting in a total of 686 vcvrack modules!)
- bring back support for building on and for x86_64 linux (64bit), i686 linux (32bit) and macos (64bit, tested on sierra) - please be aware that the linux intel builds start iconified like the linux arm builds by default (for possible low cpu usage automation scenarios)
- add support for building on and for windows in 32bit and 64bit mode
- given up on the bridge module - it is no longer developed and one can use the one from the v0 builds if required
- known problems: the FrozenWasteland plugin does not load (plugin.json not matching), some others not on macos and on windows
- see readme-macos.txt

version 1.0.0
- support for vcvrack v1.0.0
- support for 20 modules for v1
- only support arm 32bit and 64bit builds for now (intel and macos ones are no longer required, as they already contain threading, framerate limiting etc.)
- added a precompiled version for raspbian buster besides the already provided ubuntu 18.04 version
- lots of minor fixes and improvements

version 0.5.0
- initial version
