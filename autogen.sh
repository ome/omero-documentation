#!/usr/bin/env bash

set -u
set -e
set -x
OMERO_DIR=${OMERO_DIR:-$pwd}

echo "Copying history"
cp $OMERO_DIR/OMERO.server/history.txt omero/users/

echo "Generating configuration properties page"
$OMERO_DIR/OMERO.server/bin/omero config parse --rst | sed "s|$OMERO_DIR|/home/omero|" > omero/sysadmins/config.txt
mkdir -p omero/downloads/ldap

echo "Generating ldap setdn usage page"
$OMERO_DIR/OMERO.server/bin/omero ldap setdn -h | sed "s|$OMERO_DIR|/home/omero|" > omero/downloads/ldap/setdn.out

echo "Generating advanced CLI help"
$OMERO_DIR/OMERO.server/bin/omero import --advanced-help 2> advanced-help.txt || echo "Dumped"
sed 1,3d advanced-help.txt > omero/downloads/inplace/advanced-help.txt
$OMERO_DIR/OMERO.clients/importer-cli -h 2> omero/downloads/cli/help.out || echo "Dumped"

echo "Generating Web configuration temapltes"
$OMERO_DIR/OMERO.server/bin/omero web config nginx | sed "s|$OMERO_DIR|/home/omero|" > omero/sysadmins/unix/nginx-omero.conf
$OMERO_DIR/OMERO.server/bin/omero web config apache | sed "s|$OMERO_DIR|/home/omero|" > omero/sysadmins/unix/apache-omero.conf
$OMERO_DIR/OMERO.server/bin/omero web config apache-fcgi | sed "s|$OMERO_DIR|/home/omero|" > omero/sysadmins/unix/apache-fcgi-omero.conf

echo "Cleanup"
rm advanced-help.txt
