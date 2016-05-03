#!/bin/bash

set -e -u -x

WEBSESSION=${WEBSESSION:-false}

bash -eux step01_deps.sh
bash -eux step02_omero.sh

if $WEBSESSION ; then
    bash -eux step01_deps_websession.sh
fi

bash -eux step03_nginx.sh
bash -eux step04_test.sh
