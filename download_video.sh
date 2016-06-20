#!/bin/bash

echo "Download video"

# if [[ $# -eq 0 ]]
# then
#   echo "Usage: $0 <VIDEOS_FILE>"
#   exit 1
# fi

# VIDEOS=$1
# WORKING_DIR=$(pwd)
# OUTPUT_DIR=output

# mkdir -p $OUTPUT_DIR
# cd $OUTPUT_DIR

# # Download the videos from the file
# while read VIDEO
# do
#   # Download the video
#   youtube-dl --recode-video mp4 $VIDEO

#   # Extract the ID of the video which is after the 'v=' - https://www.youtube.com/watch?v=yLfd2BIJpE8
#   VIDEO_ID=$(echo $VIDEO | cut -d'=' -f2)

#   # Get the name of the file created
#   VIDEO_FILE=$(ls | grep $VIDEO_ID);

#   # Remove the ID from the video file (including the '-')
#   echo "Renaming '$VIDEO_FILE'. Removing '$VIDEO_ID' from the name"
#   rename s/-$VIDEO_ID// "$VIDEO_FILE"
# done < $WORKING_DIR/$VIDEOS

