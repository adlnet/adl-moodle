#!/bin/bash
set -ex

# read version and configuration
docker run --rm --volumes-from castle-moodle-moodle-1 bash -c "cat /var/www/html/version.php"
docker run --rm --volumes-from castle-moodle-moodle-1 bash -c "cat /var/www/html/config.php"

# show plug-in paths
docker run --rm --volumes-from castle-moodle-moodle-1 bash -c "ls -l /var/www/html/mod"
docker run --rm --volumes-from castle-moodle-moodle-1 bash -c "ls -l /var/www/html/admin"
docker run --rm --volumes-from castle-moodle-moodle-1 bash -c "ls -l /var/www/html/local"
docker run --rm --volumes-from castle-moodle-moodle-1 bash -c "ls -l /var/www/html/theme"

