#!/bin/sh

export LD_PRELOAD=./libSDL-1.2.so.0.11.4

cd /usr/bin/commander
./commander

unset LD_PRELOAD
