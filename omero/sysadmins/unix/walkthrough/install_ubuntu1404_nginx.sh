#!/bin/bash

set -e -u -x

OMEROVER=omero

source settings.env

bash -eux step01_ubuntu1404_deps.sh

bash -eux step02_all_setup.sh
bash -eux step03_all_postgres.sh

cp settings.env step04_all_$OMEROVER.sh ~omero

su - omero -c "bash -eux step04_all_$OMEROVER.sh"

bash -eux step05_ubuntu1404_nginx.sh

#If you don't want to use the init.d scripts you can start OMERO manually:
#su - omero -c "OMERO.server/bin/omero admin start"
#su - omero -c "OMERO.server/bin/omero web start"

bash -eux step06_ubuntu1404_daemon.sh

bash -eux step07_all_perms.sh

bash -eux step08_all_cron.sh

#service omero start
#service omero-web start
