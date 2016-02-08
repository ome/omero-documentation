#!/bin/bash

set -e -u -x

OMEROVER=omero
WEBAPPS=${WEBAPPS:-false}

source settings.env

bash -eux step01_centos6_deps.sh

bash -eux step02_all_setup.sh
bash -eux step03_all_postgres.sh

cp settings.env step04_all_$OMEROVER.sh ~omero

su - omero -c "bash -eux step04_all_$OMEROVER.sh"

bash -eux step05_centos6_nginx.sh

if [ $WEBAPPS = true ]; then
	PY_ENV=py26 bash -eux step05_1_all_webapps.sh
fi

#If you don't want to use the init.d scripts you can start OMERO manually:
#su - omero -c "OMERO.server/bin/omero admin start"
#su - omero -c "OMERO.server/bin/omero web start"

bash -eux step06_centos6_daemon.sh

bash -eux step07_all_perms.sh

bash -eux step08_all_cron.sh

#service omero start
#service omero-web start
