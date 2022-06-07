#!/bin/sh
# resets USB ports (should make them work again if they break lol)
# execute with sudo privileges
# based on https://askubuntu.com/a/290519/1581027
for i in /sys/bus/pci/drivers/[uoex]hci_hcd/*:*; do
  [ -e "$i" ] || continue
  echo "${i##*/}" > "${i%/*}/unbind"
  echo "${i##*/}" > "${i%/*}/bind"
done
