# !/bin/bash

cd /var/www/html/

echo Podcast updating - $(date)

#echo Syncing with put.io
#./ftp.sh

echo Downloading files

# Downloading the files
cd files
echo !!!!!!!!!!
echo Connaisseur Recordings, Adriatique, Damian Lazarus, Robot Heart, Mayan Warrior, Inner Symphony, Goldcap
echo !!!!!!!!!!
/usr/local/bin/./soundscrape https://soundcloud.com/alexconnaisseurrecordings -fn 1
/usr/local/bin/./soundscrape https://soundcloud.com/adriatique -fn 1
/usr/local/bin/./soundscrape https://soundcloud.com/damianlazarus -fn 1
/usr/local/bin/./soundscrape https://soundcloud.com/robot-heart -fn 1
/usr/local/bin/./soundscrape https://soundcloud.com/mayanwarriorofficial -fn 1
/usr/local/bin/./soundscrape https://soundcloud.com/inner-symphony -fn 1
/usr/local/bin/./soundscrape https://soundcloud.com/whiteoceanofficial -fn 3
/usr/local/bin/./soundscrape https://soundcloud.com/goldcap -fn 3
/usr/local/bin/./soundscrape https://soundcloud.com/satorimusica -fn 3
/usr/local/bin/./soundscrape https://soundcloud.com/gekautes -fn 1
/usr/local/bin/./soundscrape https://soundcloud.com/deepist -fn 3

echo " "
echo !!!!!!!!!!
echo Tamara
echo !!!!!!!!!!
/usr/local/bin/./soundscrape tamaratief -lfn 1
echo " "
echo !!!!!!!!!!
echo Adrien
echo !!!!!!!!!!
/usr/local/bin/./soundscrape adrienlacq -lfn 7
echo " "
echo !!!!!!!!!!
echo Jake
echo !!!!!!!!!!
/usr/local/bin/./soundscrape jake-christopher-wu -lfn 7
echo " "
echo !!!!!!!!!!
echo Sound of Monte Carlo
echo !!!!!!!!!!
/usr/local/bin/./soundscrape https://soundcloud.com/soundofmontecarlo -fn 2
cd ..

cd files

# Deleting podcast episodes older than 276 days
find . -type f -mtime +276 -delete

# Deleting empty folders
find . -type d -empty -delete
cd ..

# Grabbing the new podcast artwork

# Customizing the artwork

echo -ne "Creating the feed"

# Counting space used
space=$(du -sh | awk '{print $1}')
files=$(find files -type f | wc -l)
files=$((files - 1))

python genRSS.py -d files/ -e mp3,m4a --recursive --sort-creation --host 168.235.80.11 --title "ACS" --description "Last feed update: $(date), serving $files files or $space of music, enjoy!" -o feed.rss -i cover.png
echo -ne ", cleaning"
sed -i 's/&/&amp;/g' feed.rss

echo ", done."
echo "-----"
echo ""
