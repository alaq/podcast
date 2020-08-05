# Personal-soundcloud-podcast
Make your own personal podcast with soundcloud content, self-hosted

# Installation
```sh
wget -O install.sh https://raw.githubusercontent.com/alaq/podcast/master/install.sh && sh install.sh && rm install.sh
```

# ffmpeg
ffmpeg 4 is necessary on underpowered machines. In case you only get version 3 with your version of Debian/Ubuntu:
```sh
wget https://johnvansickle.com/ffmpeg/builds/ffmpeg-git-amd64-static.tar.xz
tar xvf ffmpeg-git-amd64-static.tar.xz
cp ffmpeg-git-20200803-amd64-static/ffmpeg /usr/local/bin/
```

Restart your terminal

```sh
ffmpeg --version
```
