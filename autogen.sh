#!/usr/bin/env bash

set -u
set -e
set -x
OMERO_DIR=${OMERO_DIR:-$pwd}

cp $OMERO_DIR/OMERO.server/history.txt omero/users/
$OMERO_DIR/OMERO.server/bin/omero config parse --rst > omero/sysadmins/config.txt
mkdir -p omero/downloads/ldap
$OMERO_DIR/OMERO.server/bin/omero ldap setdn -h > omero/downloads/ldap/setdn.out || echo "Dumped ldap setdn help"
$OMERO_DIR/OMERO.server/bin/omero import --advanced-help 2> advanced-help.txt || echo "Dumped advanced CLI help"
$OMERO_DIR/OMERO.server/bin/omero web config nginx | sed "s|$OMERO_DIR|/home/omero|" > omero/sysadmins/unix/nginx-omero.conf
$OMERO_DIR/OMERO.server/bin/omero web config apache | sed "s|$OMERO_DIR|/home/omero|" > omero/sysadmins/unix/apache-omero.conf
$OMERO_DIR/OMERO.server/bin/omero web config apache-fcgi | sed "s|$OMERO_DIR|/home/omero|" > omero/sysadmins/unix/apache-fcgi-omero.conf

sed 1,3d advanced-help.txt > omero/downloads/inplace/advanced-help.txt
$OMERO_DIR/OMERO.clients/importer-cli -h 2> omero/downloads/cli/help.out || echo "Dumped importer-cli help"

