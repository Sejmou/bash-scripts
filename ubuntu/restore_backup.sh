# adapted from https://askubuntu.com/questions/9135/how-to-backup-settings-and-list-of-installed-packages/99171#99171
# note to self: in bash today = $1 and today=$1 is not the same lol
today=$1
if [ ${#today} -ne 0 ];# check if date argument present (length of first argument not equal to 0)
  then today=_$today
fi

# Restoring the sources file from the backup made
cp ~/backup/sources${today}.bak /etc/apt/sources.list
# Restoring the backed-up keys
apt-key add ~/backup/repositories${today}.keys
# Update sources lists
apt-get update
# Restore the packages from the saved installed_packages.log
dpkg --clear-selections
dpkg --set-selections < ~/backup/installed_packages${today}.log && sudo apt-get dselect-upgrade
# sudo dpkg --clear-selections will mark all current packages installed for removal, that way when you restore your saved package list the packages that are not on the list will be removed from your system.

# Remove your current configuration from your home creating a backup of the folder in their current state (after all, whats the use of restoring fresh files if there are other there that can affect the configuration?)
mkdir ~/.old-gnome-config/ && mv ~/.gnome* ~/.old-gnome-config/ && mv ~/.gconf* ~/.old-gnome-config/ && mv ~/.metacity ~/.old-gnome-config/ && mv ~/.cache ~/.old-gnome-config/ && mv ~/.dbus ~/.old-gnome-config/ && mv ~/.dmrc ~/.old-gnome-config/ && mv ~/.mission-control ~/.old-gnome-config/ && mv ~/.thumbnails ~/.old-gnome-config/   && ~/.config/dconf/* ~/.old-gnome-config/