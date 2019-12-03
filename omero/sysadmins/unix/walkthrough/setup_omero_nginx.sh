#!/bin/bash
NGINXCMD=${1:-nginx}
set -eux

. `dirname $0`/settings-web.env

#start-config
omero config set omero.web.application_server wsgi-tcp
omero web config $NGINXCMD --http "$WEBPORT" > /home/omero/OMERO.server/nginx.conf.tmp
