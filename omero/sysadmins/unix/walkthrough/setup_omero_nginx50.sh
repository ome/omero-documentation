#!/bin/bash
set -e -u -x

source `dirname $0`/settings.env

#start-config
OMERO.server/bin/omero config set omero.web.application_server fastcgi-tcp
OMERO.server/bin/omero web config nginx --system --http "$OMERO_WEB_PORT" > OMERO.server/nginx.conf.tmp
