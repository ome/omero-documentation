#!/usr/bin/env bash

set -u
set -e
set -x
WORKSPACE=${WORKSPACE:-$pwd}

echo "Copying history"
cp $WORKSPACE/OMERO.server/history.txt omero/users/

echo "Generating configuration properties page"
$WORKSPACE/OMERO.server/bin/omero config parse --rst | sed "s|$WORKSPACE|/home/omero|" > omero/sysadmins/config.txt
mkdir -p omero/downloads/ldap

echo "Generating ldap setdn usage page"
$WORKSPACE/OMERO.server/bin/omero ldap setdn -h | sed "s|$WORKSPACE|/home/omero|" > omero/downloads/ldap/setdn.out

echo "Generating advanced CLI help"
$WORKSPACE/OMERO.server/bin/omero import --advanced-help 2> advanced-help.txt || echo "Dumped"
sed 1,3d advanced-help.txt > omero/downloads/inplace/advanced-help.txt
$WORKSPACE/OMERO.clients/importer-cli -h 2> omero/downloads/cli/help.out || echo "Dumped"

echo "Generating Web configuration temapltes"
$WORKSPACE/OMERO.server/bin/omero web config nginx | sed "s|$WORKSPACE|/home/omero|" > omero/sysadmins/unix/nginx-omero.conf
$WORKSPACE/OMERO.server/bin/omero web config apache | sed "s|$WORKSPACE|/home/omero|" > omero/sysadmins/unix/apache-omero.conf
$WORKSPACE/OMERO.server/bin/omero web config apache-fcgi | sed "s|$WORKSPACE|/home/omero|" > omero/sysadmins/unix/apache-fcgi-omero.conf

echo "Cleanup"
rm advanced-help.txt
