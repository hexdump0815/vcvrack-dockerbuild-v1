to run vcvrack on the raspberry pi with raspbian buster some special steps are required to make it work:

- you need the latest raspbian buster image for this as a base!
- this should work for the raspberry pi 3b, 3b+ and 4b+ - you'll most probably need a fan to keep the pi cool - maybe it even works on the raspberry pi 2b, but it might be too slow to be useful ...
- enable the full dkms opengl driver (as root run raspi-config -> advanced options -> gl driver -> full kms opengl driveri - then reboot)
- start and configure jack (as user pi run qjackctl -> setup: alsa driver, default interface, realtime, 44100khz, 1024 frames, 2 buffers, advanced: force 16bit, playback only - ok - start )
- do some audio tuning - run as root:
---snip---
#!/bin/bash

if [ -f /proc/sys/fs/inotify/max_user_watches ]; then
  echo 524288 > /proc/sys/fs/inotify/max_user_watches
fi

for i in /sys/devices/system/cpu/cpu?/cpufreq/scaling_governor ; do
  echo performance > $i
done

# make jackd happy with realtime prio
sysctl -w kernel.sched_rt_runtime_us=-1
---snip---
- download and unpack vcvrack.raspbian-v1.tar.gz
- cd vcvrack.raspbian-v1
- ./Rack -d
- qjackctl go to connections -> audio -> connect vcvrack to system
- press some keys the lowest keyboard row and you should see some waveforms on the scope of the template patch and hear some sound
- try to load some patches - for instance from: https://github.com/hexdump0815/sonaremin/tree/master/files/data/vcvrack-v1
- good luck and enjoy :)
