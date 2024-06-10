#!/bin/bash

VERSION=4.4.0

echo
echo "This script will upgrade Moodle to the version specified in this script: ${VERSION}"
echo
echo "1. Make sure Moodle plug-in updates have been completed online, and that Moodle has been backed up."
echo "2. Make sure the in-docker-upgrade.sh specifies all of the installed plug-ins."
echo

while true; do
    read -p "$*  Are you sure you want to continue? [y/n]: " yn
    case $yn in
        [Yy]*) break  ;;  
        [Nn]*) echo "\nAborted.\n" ; exit 1 ;;
    esac
done

if [ ! -d /home/ubuntu/backup ]; then
    echo
    echo "Aborting. Backup directory not found. (You should do a backup)"
    exit 1
fi

set -ex

# Make sure the new version has been downloaded
docker pull registry1.dso.mil/ironbank/opensource/moodle:${VERSION}

# stop the containers
docker-compose down

# start the latest version of the base image, 
# mount the existing volume to /tmp/currentvolume, 
# execute the upgrade script
docker run --rm -i --tty -u root \
                   -v castle-moodle_moodle_www-data:/tmp/currentvolume \
                   -v /home/ubuntu/castle-moodle/scripts:/tmp/scripts \
                   -v /home/ubuntu/castle-moodle/themes:/tmp/themes \
                   registry1.dso.mil/ironbank/opensource/moodle:${VERSION} \
                   bash -c "cd /tmp/scripts && sh in-docker-upgrade.sh"

# start the container back up
docker-compose up --build -d
