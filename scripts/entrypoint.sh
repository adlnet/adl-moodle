#!/bin/sh
set -e

if [ "$1" = "php-fpm" ]; then

  if [ ! -f /var/www/html/config.php ]; then

    # wait for the database
    sleep 3
    echo "Waiting for database... to configure Moodle..."
    sleep 10

    echo "Configuring Moodle..."

    chown -R appuser:appuser /var/www/html
    chmod -R 2755 /var/www/html

    gosu appuser php /var/www/html/admin/cli/install.php \
      --lang=en \
      --chmod=2775 \
      --wwwroot="${MOODLE_URL_SCHEME}://${MOODLE_HOST}" \
      --dataroot=/var/www/moodledata \
      --adminuser="${MOODLE_ADMIN_USERNAME}" \
      --adminpass="${MOODLE_ADMIN_PASSWORD}" \
      --adminemail="${MOODLE_ADMIN_EMAIL}" \
      --fullname="${MOODLE_SITE_LONG_NAME}" \
      --shortname="${MOODLE_SITE_SHORT_NAME}" \
      --non-interactive \
      --agree-license \
      --allow-unstable \
      --dbtype=${MOODLE_DB_TYPE} \
      --dbhost="${MOODLE_DATABASE_HOST}" \
      --dbport=${MOODLE_DB_PORT} \
      --dbname="${MOODLE_DATABASE_NAME}" \
      --dbuser="${MOODLE_DATABASE_USER}" \
      --dbpass="${MOODLE_DATABASE_PASSWORD}"

  fi

  if [ -f /var/www/html/config.php ]; then
    echo "Moodle is configured"
  fi

  ## @todo Check if file permissions are correct, like after an upgrade
  chown -R appuser:appuser /var/www/html /var/www/moodledata
  chmod -R 2755 /var/www/html /var/www/moodledata
  echo "Directory permissions updated"

  ## Start the cron
  /usr/sbin/crond -s -p
  echo "Cron started"

  echo "Starting PHP-FPM"
  chmod -R 2755 /var/log/php-fpm
  chown appuser:appuser /var/log/php-fpm
fi

exec gosu appuser "$@"
