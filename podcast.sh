#!/bin/bash

mkdir -p "$HOME/audio/.archives"
cd "$HOME/audio"

dl () {
    youtube-dl --download-archive .archives/"$1".txt -f         \
        bestaudio --dateafter 20200801                          \
        --embed-thumbnail --add-metadata                        \
        --playlist-end 5 "$2"
    sleep 5
}

dl don-edwardo https://soundcloud.com/edwardo-ghazal/

echo "Deleting old sets"
# Deleting podcast episodes older than 276 days
find . -type f -mtime +100 -delete

echo Counting space used
# Counting space used
space=$(du -sh | awk '{print $1}')
files=$(find . -type f | wc -l)
files=$((files - 2))

echo "Generating feed"
python3 ~/genRSS/genRSS.py -d / -e mp3,m4a --recursive --sort-creation --host 168.235.65.61 --title "ACS" --description "Last feed update: $(date), serving $files files or $space of music, enjoy!" -o feed.rss -i cover.png
# python genRSS.py -d files/ -e mp3,m4a --recursive --sort-creation --host 168.235.80.11 --title "ACS" --description "Last feed update: $(date), serving $files files or $space of music, enjoy!" -o feed.rss -i cover.png
sed -i 's/&/&amp;/g' feed.rss

