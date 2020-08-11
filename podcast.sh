#!/bin/bash

mkdir -p "/var/www/html/files"
touch ~/podcast-archive.txt
cd "/var/www/html/files"

dl () {
    /usr/local/bin/youtube-dl --download-archive ~/podcast-archive.txt -f    \
        bestaudio --embed-thumbnail --add-metadata            \
	-o '%(uploader)s - %(title)s'      \
        --playlist-end ${2:-1} "$1"
    sleep 5
}

dl https://soundcloud.com/edwardo-ghazal/
dl https://soundcloud.com/rolandsons-seasidetrip
dl https://soundcloud.com/mayanwarriorofficial
dl https://soundcloud.com/adrienlacq/likes 5

echo "Deleting old sets"
# Deleting podcast episodes older than 276 days
#find . -type f -mtime +100 -delete

echo Counting space used
# Counting space used
space=$(du -sh | awk '{print $1}')
files=$(find . -type f | wc -l)

cd ..

echo "Generating feed"
python3 ~/genRSS/genRSS.py -d files/ -e mp3,m4a --recursive --sort-creation --host podcast.alaq.io --title "ACS" --description "Last feed update: $(date), serving $files files or $space of music, enjoy!" -o feed.rss -i cover.png
sed -i 's/&/&amp;/g' feed.rss

