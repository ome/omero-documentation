#!/bin/bash

# See setup_omero.sh for the nginx config file creation

mv /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.disabled
cp OMERO.server/nginx.conf.tmp /etc/nginx/conf.d/omero-web.conf

service nginx start
