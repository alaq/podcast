#!/bin/bash

FILES="/var/www/html/files"

mkdir -p $FILES
touch ~/podcast-archive.txt
cd $FILES

dl () {
    /usr/local/bin/youtube-dl --download-archive ~/podcast-archive.txt -f    \
        bestaudio --embed-thumbnail --add-metadata            \
	--match-filter 'duration > 2400' \
	-o '%(uploader)s - %(title)s.%(ext)s'      \
        --playlist-end ${2:-1} "$1"
    sleep 5
}

dl https://soundcloud.com/edwardo-ghazal/
dl https://soundcloud.com/rolandsons-seasidetrip
dl https://soundcloud.com/mayanwarriorofficial
dl https://soundcloud.com/adrienlacq/likes 5

echo "Deleting old sets"
# Deleting podcast episodes older than 276 days

usage=$(du -sb $FILES | cut -d $'\t' -f 1)
max=8000000000
if (( usage > max ))
then
  find $FILES -maxdepth 1 -type f -printf '%T@\t%s\t%p\n' | sort -n | \
    while (( usage > max )) && IFS=$'\t' read timestamp size file
    do
      echo "Deleting $file"
      rm -- "$file" && (( usage -= size ))
    done
fi

echo Counting space used
# Counting space used
space=$(du -sh | awk '{print $1}')
files=$(find . -type f | wc -l)

cd ..

echo "Generating feed"
python3 ~/genRSS/genRSS.py -d files/ -e mp3,m4a --recursive --sort-creation --host podcast.alaq.io --title "ACS" --description "Last feed update: $(date), serving $files files or $space of music, enjoy!" -o feed.rss -i cover.png
sed -i 's/&/&amp;/g' feed.rss

