the build process on macos does not use docker - the order of things to do thus is:

./prepare-macos-brew.sh
./prepare.sh
./compile/build.sh
./prepare-modules.sh
./compile/build-modules.sh
./make-dist.sh

and assumes a working brew https://brew.sh/ installation

the Bogaudio, DHE and Surge modules do not load properly in this build
