#!/bin/bash

source utils.sh

WORKING_DIR=$(pwd)
INSTALL_DIR="/opt/joggle"
CONFIG_DIR="~/.config/youtube-dl/"

read -p "Select your OS [mac|ubuntu] (default: mac): " $USER_OS
USER_OS=${USER_OS:-mac}

if [ "$USER_OS" = "mac" ]; then
  brew install ffmpeg curl
  print_message "You may need to provide your sudo password" "info"
else
  if [[ "$EUID" -ne 0 ]]; then
    print_message "You must be root to run this script" "error"
    exit 1
  fi
  sudo apt-get -y install ffmpeg curl
fi

sudo curl -L https://yt-dl.org/latest/youtube-dl -o /usr/local/bin/youtube-dl
sudo chmod a+rx /usr/local/bin/youtube-dl

# Install the scripts
sudo mkdir -p $INSTALL_DIR
sudo chown -R $(whoami): $INSTALL_DIR
cp *.sh README.md $INSTALL_DIR
cd $INSTALL_DIR
ln -fns /opt/joggle/joggle.sh /usr/local/bin/joggle

# Config file under ~/.config/youtube-dl/config
cd $WORKING_DIR
mkdir -p ~/.config/youtube-dl
sudo chown -R $(whoami): $CONFIG_DIR
cp config/youtube-dl_config ~/.config/youtube-dl/config