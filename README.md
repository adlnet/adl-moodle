# Moodle running under Nginx/PHP-FPM with PostgreSQL

Build with Docker or run a full environment with Docker Compose.

Moodle VM is Ubuntu 20.04.4 LTS

Make sure Ubuntu is up-to-date:

```
$ sudo apt update
$ sudo apt upgrade
```

## Deployment Keys for Production Systems

```bash
$ ssh-keygen -t ed25519 -C "example@adlnet.gov"
$ vi ~/.ssh/config
```

```text
Host github.com-repo-0
    Hostname github.com
    IdentityFile=/home/ubuntu/.ssh/id_ed25519
```

<https://github.com/adlnet/castle-moodle/settings/keys>

Clone the Repo

```bash
$ git clone git@github.com-repo-0:adlnet/castle-moodle.git
```

## Install Docker

```
$ sh scripts/install-docker.sh
```

## Download the dependencies

Before building, the build's external dependencies must be downloaded.

```
$ sh scripts/download-deps.sh
```

## Login to registry1

```
docker login https://registry1.dso.mil
```

## Build and run with Docker Compose

First you will need a .env file with this environment's settings. Startup will install and maintain an SSL certificate.

```
$ cp env-moodle .env
$ vi .env
```

Example config:

```
MOODLE_SITE_LONG_NAME=
MOODLE_SITE_SHORT_NAME=

MOODLE_URL_SCHEME=https
MOODLE_HOST=localhost

MOODLE_ADMIN_USERNAME=lowercase_username
MOODLE_ADMIN_PASSWORD=password_with_upper_and_lowercase
MOODLE_ADMIN_EMAIL=

MOODLE_DB_PASSWORD=

NGINX_HOSTNAME=localhost
LETS_ENCRYPT_EMAIL=

```

Next, build and run everything.

Running includes:
1. Configuring an SSL certificate (this will automatically generate a self-signed or request a certbot certificate)
2. Starting crond for background tasks
3. Configuring Moodle for PHP, MariaDB/PostgreSQL, and the Admin credentials
4. Starting Apache
5. Directory volumes for SSL Certificates, Moodle Application, Moodle Data, and Database

```
$ export DOCKER_BUILDKIT=1
$ docker-compose up --build -d
```

## Login to Moodle

Open a browser to Moodle, for example, https://localhost

Use the admin credentials you set in .env to login, then finish setting up your Moodle site.

## Upgrading

1. Backup the database (scripts/backup.sh)
2. Rebuild docker images (docker-compose up --build -d)
3. Run the upgrade script (scripts/upgrade-moodle-version.sh)
4. Log into Moodle, confirm the upgrade process


## Backups

Backups are in ~/backup

```bash
$ scripts/backup.sh
```


## Restore

A script uses the latest database and file backup from backup.sh, destroys the current data, then restores it all.

```bash
$ scripts/restore.sh
```

## Moodle Plug-Ins

The following plug-ins are manually installed using the web-based Moodle Admin Plug-Ins interface:

* [Course Certificate](https://moodle.org/plugins/mod_coursecertificate)
* [Certificate Manager](https://moodle.org/plugins/tool_certificate)
* [Logstore xAPI](https://moodle.org/plugins/logstore_xapi) [[releases](https://github.com/xAPI-vle/moodle-logstore_xapi/releases)]
* [User Bulk Enrolment](https://moodle.org/plugins/local_bulkenrol) [[source](https://github.com/moodle-an-hochschulen/moodle-local_bulkenrol)]
* [Sharing Cart](https://moodle.org/plugins/block_sharing_cart) [[source](https://github.com/donhinkelman/moodle-block_sharing_cart)]

The following plug-ins are included in Moodle:

* Big Blue Button
* Open Badges

## BigBlueButton Server

BigBlueButton requires Ubuntu 18.04.6 LTS

Web conferencing requires a separate server for the BBB Moodle Plug-In to handle the demanding requirements of web conferencing.

BBB Installation on Ubuntu 18, as root user is simply:

```
wget -qO- https://ubuntu.bigbluebutton.org/bbb-install.sh | bash -s -- -w -a -v bionic-24 -s example.com -e email@example.com
```

Do not install Greenlight (it's a completely separate web application), and **remove the API Demos** as instructed.

Then, BBB provides a single command to verify, control, and upgrade the application.

As root user, the command to view the options is:

```
$ bbb-conf
```

## Logstore xAPI Plug-In Setup

Install the Plug-in.

Configure the Plug-in
1. Set the “endpoint” to the LRS endpoint
2. Set the “username” to the LRS basic auth key/username
3. Set the “password” to the LRS basic auth secret/password
4. Click “Save changes”

Enable the Plug-in
1. Navigate to the list of Moodle Server Plug-Ins
2. Now in the Plug-Ins list, find the section “Log store manager / Log stores”
3. In the list of logging components, click the Eyeball to enable the Logstore xAPI feature

Test the Plug-in
1. View some courses
2. Wait some time (statements are batched periodically)
3. Login to the LRS and verify the information is there

**NOTE: This plug-in uses libcurl and Moodle has a separate allowed/blocked IP lists for curl in Admin.**


## Steps for System Integration

1. Review the instructions: Navigate to Admin -> Server -> Web Services Overview
2. Enable Web Services: Navigate to Administration > Site administration > Advanced features
3. Enable REST: Administration > Site administration > Server > Web services > Manage protocols
4. Navigate to Admin -> Users -> You must have a new user like "castle-portal" to grant API access
5. Manage Tokens: Administration > Site administration > Server > Web services > Manage tokens
6. Grant functions for the portal user

 
### Web Service Functions

Available functions:
<https://docs.moodle.org/dev/Web_service_API_functions>

#### User and Course Enrollments

* core_enrol_get_enrolled_users
* core_enrol_get_users_courses
* core_user_get_users_by_field


## Themes

### How To Install Moodle Theme (From Drop Down Selection) for development

Themes are copied into the image as part of the docker build. (uncomment to work on the theme in dev)

The `portal` theme is the currently recommended plug-in which displays the site logo.

You can change your moodle theme to a custom theme easily via Moodle.

* Step 1- Log into Moodle
* Step 2- Click on _Administration_
* Step 3- Click on _Appearance_
* Step 4- Click on _Themes_
* Step 5- Click on _Theme Selectors_
* Step 6- Click on _CustomMoodleTheme_ and click APPLY.

You should now see your moodle theme applied globally throughout the application for you.

### How To Install Moodle Theme via ZIP (Directly From Moodle)

Any custom theme is seen as a plugin on Moodle. So, the following instructions apply.

* Login to your Moodle site as an admin and go to Administration > Site administration > Plugins > Install plugins.
* Upload the ZIP file. You should only be prompted to add extra details (in the Show more section) if your plugin is not automatically detected.
* If your target directory is not writeable, you will see a warning message.
* Check the plugin validation report

## Production Moodle Checklist

[ ] Turn off guest access, in Admin
[ ] Turn off showing content before the user logs in, in Admin
[ ] Install the en_us language pack (can be done in Admin)
[ ] Configure the default language pack setting for all users (update your own manually)
[ ] Set the site image and compact image (will show in login page and header)
[ ] Optionally Upload the portal.zip theme plug-in
[ ] Upload and activate plug-ins: Logstore xAPI, Certificate, Bulk Enrol
[ ] Configure OAuth/OIDC with Keycloak configuration

## Debugging

For development only, turn on debugging by editing the config.php file:

```php
$CFG->debug = 32767;
$CFG->debugdisplay = true;
```

