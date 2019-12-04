#!/bin/bash

set -e -u -x

. `dirname $0`/settings.env

#start-config
psql -h localhost -U "$OMERO_DB_USER" "$OMERO_DB_NAME" < $OMERODIR/db.sql
