#!/bin/bash

VIDEO=$1
AUDIO=$2

ffmpeg -i $VIDEO -acodec libmp3lame $AUDIO.mp3
