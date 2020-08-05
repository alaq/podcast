#!/bin/bash

sudo apt update && sudo apt upgrade -y
sudo apt install git curl apache2 -y

curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl
sudo chmod a+rx /usr/local/bin/youtube-dl

git clone https://github.com/alaq/podcast

sudo crontab $HOME/podcast/crontab
