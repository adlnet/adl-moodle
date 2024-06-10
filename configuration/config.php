<?php
///////////////////////////////////////////////////////////////////////////
//                                                                       //
// Moodle configuration file                                             //
//                                                                       //
// This file should be renamed "config.php" in the top-level directory   //
//                                                                       //
///////////////////////////////////////////////////////////////////////////
//                                                                       //
// NOTICE OF COPYRIGHT                                                   //
//                                                                       //
// Moodle - Modular Object-Oriented Dynamic Learning Environment         //
//          http://moodle.org                                            //
//                                                                       //
// Copyright (C) 1999 onwards  Martin Dougiamas  http://moodle.com       //
//                                                                       //
// This program is free software; you can redistribute it and/or modify  //
// it under the terms of the GNU General Public License as published by  //
// the Free Software Foundation; either version 3 of the License, or     //
// (at your option) any later version.                                   //
//                                                                       //
// This program is distributed in the hope that it will be useful,       //
// but WITHOUT ANY WARRANTY; without even the implied warranty of        //
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         //
// GNU General Public License for more details:                          //
//                                                                       //
//          http://www.gnu.org/copyleft/gpl.html                         //
//                                                                       //
///////////////////////////////////////////////////////////////////////////
unset($CFG);  // Ignore this line
global $CFG;  // This is necessary here for PHPUnit execution
$CFG = new stdClass();

$CFG->disableupdateautodeploy = false;

$CFG->dbtype    = 'pgsql';      // 'pgsql', 'mariadb', 'mysqli', 'auroramysql', 'sqlsrv' or 'oci'
$CFG->dblibrary = 'native';     // 'native' only at the moment
$CFG->dbhost    = getenv('PGHOST') ?: 'db';  // eg 'localhost' or 'db.isp.com' or IP
$CFG->dbname    = getenv('PG_DATABASE') ?: 'moodle';     // database name, eg moodle
$CFG->dbuser    = getenv('PG_USER');   
$CFG->dbpass    = getenv('APP_DB_ADMIN_PASSWORD'); 
$CFG->prefix    = 'mdl_';       // prefix to use for all table names
$CFG->dboptions = array(
    'dbpersist' => false,       
    'dbsocket'  => false,       
    'dbport'    => getenv('PGPORT') ?: '',          
    'dbhandlesoptions' => false,
    'dbcollation' => 'utf8mb4_unicode_ci',
);

//$CFG->reverseproxy = true;

$CFG->sslproxy = true;

//$CFG->wwwroot   = "https://".$_SERVER["HTTP_HOST"];//getenv('MOODLE_HOST') ?: 'https://localhost';//'moodle.staging.dso.mil'; //getenv('MOODLE_HOST') ?: 'https://localhost';

$CFG->wwwroot   = getenv('MOODLE_HOST');

$CFG->dataroot  = '/var/www/moodledata';

$CFG->directorypermissions = 02777;

$CFG->xsendfile = 'X-Accel-Redirect';
$CFG->xsendfilealiases = array(
    '/dataroot/' => $CFG->dataroot
);

$CFG->admin = 'admin';

require_once(__DIR__ . '/lib/setup.php'); // Do not edit
