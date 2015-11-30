#!/usr/bin/env bash
# Setup OMERO.web using nginx

set -e
set -u
set -x

export PATH=/usr/local/bin:$PATH
export HTTPPORT=${HTTPPORT:-8080}
export ICE_CONFIG=$(bin/brew --prefix omero52)/etc/ice.config
export PYTHONPATH=$(bin/brew --prefix omero52)/lib/python

# Setup nginx
omero web config nginx-development --http $HTTPPORT > $(brew --prefix omero52)/etc/nginx.conf
