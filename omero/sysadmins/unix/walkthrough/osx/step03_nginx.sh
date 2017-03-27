#!/usr/bin/env bash
# Setup OMERO.web using nginx

set -e
set -u
set -x

export PATH=/usr/local/bin:$PATH
export HTTPPORT=${HTTPPORT:-8080}
export ICE_CONFIG=$(brew --prefix omero53)/etc/ice.config
export PYTHONPATH=$(brew --prefix omero53)/lib/python

# Setup nginx
omero web config nginx-development --http $HTTPPORT > $(brew --prefix omero53)/etc/nginx.conf
