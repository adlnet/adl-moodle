#!/bin/bash
set -ex

mkdir -p /home/ubuntu/backup

# https://docs.docker.com/storage/volumes/#backup-restore-or-migrate-data-volumes

# Backup the PostgreSQL database
docker exec castle-moodle-db-1 /usr/bin/pg_dump -O -U moodle -d moodle > /home/ubuntu/backup/moodle-db.sql
gzip --force /home/ubuntu/backup/moodle-db.sql

# Backup the MySQL database
#docker exec castle-moodle-db-1 /usr/bin/mysqldump -u moodle --password=${PW} moodle > /home/ubuntu/backup/moodle-db.sql
#gzip --force /home/ubuntu/backup/moodle-db.sql

# Backup Moodle /var/www/html
docker run --rm --volumes-from castle-moodle-moodle-1 -v /home/ubuntu/backup:/backup ubuntu tar czf /backup/moodle-www.tar.gz /var/www/html

# Backup Moodle /var/www/moodledata
docker run --rm --volumes-from castle-moodle-moodle-1 -v /home/ubuntu/backup:/backup ubuntu tar czf /backup/moodle-data.tar.gz /var/www/moodledata

# Backup the config separately so it's easier to restore
docker run --rm --volumes-from castle-moodle-moodle-1 -v /home/ubuntu/backup:/backup ubuntu tar czf /backup/moodle-config.tar.gz /var/www/html/config.php

# Backup the plug-ins and theme separately so they are easier to restore
docker run --rm --volumes-from castle-moodle-moodle-1 -v /home/ubuntu/backup:/backup ubuntu tar czf /backup/moodle-plugins.tar.gz \
  /var/www/html/mod/coursecertificate \
  /var/www/html/admin/tool/log/store/xapi \
  /var/www/html/admin/tool/certificate \
  /var/www/html/local/bulkenrol \
  /var/www/html/blocks/sharing_cart \
  /var/www/html/theme/portal

# Backup LetsEncrypt /etc/letsencrypt
docker run --rm --volumes-from moodle-webserver -v /home/ubuntu/backup:/backup ubuntu tar czf /backup/letsencrypt-backup.tar.gz /etc/letsencrypt

echo
echo Finished
echo
