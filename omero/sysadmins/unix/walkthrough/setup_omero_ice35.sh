#!/bin/bash

set -e -u -x

source settings.env

SERVER=http://downloads.openmicroscopy.org/omero/5.0.1/artifacts/OMERO.server-5.0.1-ice35-b21.zip

wget $SERVER
unzip -q `basename $SERVER`
ln -s `basename "${SERVER%.zip}"` OMERO.server

OMERO.server/bin/omero config set omero.data.dir "$OMERO_DATA_DIR"
OMERO.server/bin/omero config set omero.db.name "$OMERO_DB_NAME"
OMERO.server/bin/omero config set omero.db.user "$OMERO_DB_USER"
OMERO.server/bin/omero config set omero.db.pass "$OMERO_DB_PASS"
OMERO.server/bin/omero db script -f OMERO.server/db.sql "" "" "$OMERO_ROOT_PASS"

psql -h localhost -U "$OMERO_DB_USER" "$OMERO_DB_NAME" < OMERO.server/db.sql

OMERO.server/bin/omero web config nginx --system --http "$OMERO_WEB_PORT" > OMERO.server/nginx.conf.tmp
