# temporary workaround for droidcam that just reinstalls it lol (I almost always get loopback device not found error on startup)
cd /tmp/

# download latest version
wget -O droidcam_latest.zip https://files.dev47apps.net/linux/droidcam_1.8.2.zip
# sha1sum: d1038e6d62cac6f60b0dd8caa8d5849c79065a7b
unzip droidcam_latest.zip -d droidcam

# install client
cd droidcam && sudo ./install-client

# install video driver
sudo apt install linux-headers-`uname -r` gcc make
sudo ./install-video