#!/usr/bin/env bash
# This script is used by a Continuous Integration job to auto-generate
# the configuration files for running omero

set -u
set -e
set -x
set -o pipefail

WORKSPACE=${WORKSPACE:-$(pwd)}
WORKSPACE=${WORKSPACE%/}  # Remove trailing slashes
export DOCVENV=${DOCVENV:-$WORKSPACE/.venv3}


$DOCVENV/bin/pip install "omero-web[redis]"

echo "Generating configuration properties page"
$DOCVENV/bin/omero config parse --rst | sed "s|$SUFFIX||" | sed "s|$WORKSPACE|/home/omero|" > omero/sysadmins/config.rst

echo "Generating ldap setdn usage page"
mkdir -p omero/downloads/ldap
$DOCVENV/bin/omero ldap setdn -h | sed "s|usage:.*/omero|usage: omero|" > omero/downloads/ldap/setdn.out

echo "Generating advanced CLI help"
$DOCVENV/bin/omero import --advanced-help 2> advanced-help.txt || echo "Dumped"
sed 1,5d advanced-help.txt > omero/downloads/inplace/advanced-help.txt
$DOCVENV/bin/omero import --javahelp 2> java-help.txt || echo "Dumped"
sed 1,5d java-help.txt > omero/downloads/cli/help.out

echo "Generating DB script example"
$DOCVENV/bin/omero db script --password secretpassword 2>&1 | sed "s|Saving to.*/|Saving to /home/omero/|" > omero/downloads/cli/db-script-example.txt
rm OMERO*sql


echo "Generating Web configuration templates"
# Nginx / WSGI
$DOCVENV/bin/omero config set omero.web.application_server wsgi-tcp
$DOCVENV/bin/omero web config nginx | sed "s|$SUFFIX||" | sed "s|$WORKSPACE/OMERO.server|/opt/omero/web/omero-web|g" > omero/sysadmins/unix/install-web/nginx-omero.conf
$DOCVENV/bin/omero web config nginx-location | sed "s|$SUFFIX||" | sed "s|$WORKSPACE/OMERO.server|/opt/omero/web/omero-web|g" | grep -v '^#' > omero/sysadmins/unix/install-web/nginx-location.conf
