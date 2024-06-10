#!/bin/bash
set -ex

# NOTE: This script runs from within the docker container, from the host upgrade.sh script
# REQUIES: -v my-docker-volume:/tmp/currentvolume

# Replace the current Moodle with the latest
mkdir /tmp/old
mv /tmp/currentvolume/* /tmp/old/
cp -pR /var/www/html/* /tmp/currentvolume/

# Install the previous configuration
cp -p /tmp/old/config.php /tmp/currentvolume/
chown -R 1001:root /tmp/currentvolume

#############################################
# Restore all manually installed plug-ins

# Certificate Plug-in
if [ -d /tmp/old/mod/coursecertificate ]; then
  cp -pR /tmp/old/mod/coursecertificate /tmp/currentvolume/mod/
fi
if [ -d /tmp/old/admin/tool/certificate ]; then
  cp -pR /tmp/old/admin/tool/certificate /tmp/currentvolume/admin/tool/
fi

# LogStore xAPI Plug-in
if [ -d /tmp/old/admin/tool/log/store/xapi ]; then
  cp -pR /tmp/old/admin/tool/log/store/xapi /tmp/currentvolume/admin/tool/log/store/
fi

# Bulkenrol Plug-in
if [ -d /tmp/old/local/bulkenrol ]; then
  cp -pR /tmp/old/local/bulkenrol /tmp/currentvolume/local/
fi

# Sharing_Cart Plug-in
if [ -d /tmp/old/blocks/sharing_cart ]; then
  cp -pR /tmp/old/blocks/sharing_cart /tmp/currentvolume/blocks/
fi

# Theme from backup
# cp -pR /tmp/old/theme/portal /tmp/currentvolume/theme/

# Theme from repo
cp -pR /tmp/themes/portal /tmp/currentvolume/theme/
