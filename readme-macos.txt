the build process on macos does not use docker - the order of things to do thus is:

./prepare-macos-brew.sh
./prepare.sh
./compile/build.sh
./prepare-modules.sh
./compile/build-modules.sh
./make-dist.sh

and assumes a working brew https://brew.sh/ installation

due to compile errors some modules had to be disabled:

Bidoo
- cANARd
- OUAIve
- liMonADe (had to be disabled too to make it load properly)

FrozenWasteland
- PortlandWeather

the workaround to disable them in the build does not seem to help - they and some others too (DHE-Modules, Surge for Rack) fail to load on startup vcvrack - needs some investigation
