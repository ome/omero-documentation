#!/bin/bash
NGINXCMD=${1:-nginx}
set -e -u -x

source `dirname $0`/settings-web.env

#start-config
OMERO.server/bin/omero config set omero.web.application_server wsgi-tcp
OMERO.server/bin/omero web config $NGINXCMD --http "$OMERO_WEB_PORT" > OMERO.server/nginx.conf.tmp
