#!/bin/bash

sudo apt update && sudo apt upgrade -y
sudo apt install git curl -y

curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl
sudo chmod a+rx /usr/local/bin/youtube-dl

sudo crontab $HOME/podcast/crontab
