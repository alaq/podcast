# personal-soundcloud-podcast
Make your own personal podcast with soundcloud content, selft hosted

# install
1. mkdir files/
2. chmod 777 tasks.sh
3. add tasks.sh to your crontab (`crontab -e`, then add the line `*/15 * * * * /var/www/html/./tasks.sh >> /var/www/html/log.txt`
4. subscribe your podcast client to url/feed.rss
