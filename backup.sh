# adapted from https://askubuntu.com/questions/9135/how-to-backup-settings-and-list-of-installed-packages/99171#99171
# get current date (localized, including time)
today=$(date)
#convert to date of format YYYY-MM-DD
printf -v today '%(%Y-%m-%d)T' -1
# add prefix for filename
today=_${today}
# Save the currently installed packages list
dpkg --get-selections > ~/backup/installed_packages${today}.log
# Make a backup of apt sources file...
cp /etc/apt/sources.list ~/backup/sources${today}.bak
# ...and a copy of apt's list of trusted keys
apt-key exportall > ~/backup/repositories${today}.keys
