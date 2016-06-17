#!/bin/bash

INPUT_FILE=$1
OUTPUT_FILE=$INPUT_FILE"_corte.mp3"

START=$2
DURATION=$3

ffmpeg -ss $START -t $DURATION -i $INPUT_FILE -acodec copy $OUTPUT_FILE