#!/bin/bash

source utils.sh

if [[ "$EUID" -ne 0 ]]; then
  print_message "You must be root to run this script" "error"
  exit 1
fi

WORKING_DIR=$(pwd)
INSTALL_DIR="/opt/joggle"

# Install dependencies - youtube-dl, ffmpeg
sudo apt-get -y install ffmpeg curl

sudo curl -L https://yt-dl.org/latest/youtube-dl -o /usr/local/bin/youtube-dl
sudo chmod a+rx /usr/local/bin/youtube-dl

# Install the scripts
mkdir -p $INSTALL_DIR
cp *.sh README.md $INSTALL_DIR
cd $INSTALL_DIR
ln -fns /opt/joggle/joggle.sh /usr/local/bin/joggle

# Config file under ~/.config/youtube-dl/config
cd $WORKING_DIR
mkdir -p ~/.config/youtube-dl
cp config/youtube-dl_config ~/.config/youtube-dl/config