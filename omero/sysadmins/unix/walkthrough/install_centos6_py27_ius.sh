#!/bin/bash

set -e -u -x

source settings.env

bash -eux step01_centos6_py27_ius_deps.sh

bash -eux step02_centos6_py27_ius_setup.sh
bash -eux step03_all_postgres.sh

#If you don't want to use the init.d scripts you can start OMERO manually:
#su - omero -c "OMERO.server/bin/omero admin start"
#su - omero -c "OMERO.server/bin/omero web start"

bash -eux step08_all_cron.sh

#service omero start
#service omero-web start