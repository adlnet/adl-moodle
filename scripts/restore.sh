#!/bin/bash
set -ex

echo
echo "This script will replace/restore a Moodle system's database and files to the point of the last backup."
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
    echo "Aborting. Backup directory not found."
    exit 1
fi

# prep the compressed file
gunzip /home/ubuntu/backup/moodle-db.sql.gz

# bring everything down
docker-compose down

# Restore the PostgreSQL database
docker run --name temp-postgresql --rm -d \
           -v castle-moodle_moodle_db-data:/var/lib/postgresql/data \
           -v /home/ubuntu/backup:/backup \
           registry1.dso.mil/ironbank/opensource/postgres/postgresql:13.6
docker exec temp-postgresql dropdb -U moodle moodle
docker exec temp-postgresql createdb -U moodle moodle
docker exec temp-postgresql psql -U moodle -f /backup/moodle-db.sql moodle
docker stop temp-postgresql

# Restore the web and data volumes
docker run --name temp-container -d \
           -v castle-moodle_moodle_www-data:/var/www/html \
           -v castle-moodle_moodle_moodle-data:/var/www/moodledata \
           -v /home/ubuntu/backup:/backup \
           ubuntu

# These directories and volumes should exist
# docker run --rm --volumes-from temp-container bash -c "ls -l /var/www/html"
# docker run --rm --volumes-from temp-container bash -c "ls -l /var/www/moodledata"
# docker run --rm --volumes-from temp-container bash -c "ls -l /backup"

# Remove the volume data and restore from backups
docker run --rm --volumes-from temp-container bash -c "rm -rf /var/www/html/*"
docker run --rm --volumes-from temp-container bash -c "rm -rf /var/www/moodledata/*"
docker run --rm --volumes-from temp-container bash -c "cd / && tar xvzf /backup/moodle-www.tar.gz"
docker run --rm --volumes-from temp-container bash -c "cd / && tar xvzf /backup/moodle-data.tar.gz"

docker rm temp-container

echo
echo Finished
echo
