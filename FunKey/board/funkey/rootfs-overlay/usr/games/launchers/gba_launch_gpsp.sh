#!/bin/sh

# Launch the process in background, record the PID into a file, wait
# for the process to terminate and erase the recorded PID
# Do not use asound.conf to avoid saturated sound
rw
mv -f /etc/asound.conf /etc/asound.conf.BAK
picoarch /usr/games/gpsp_libretro.so "$1"&
pid record $!
wait $!
pid erase
mv -f /etc/asound.conf.BAK /etc/asound.conf
ro
