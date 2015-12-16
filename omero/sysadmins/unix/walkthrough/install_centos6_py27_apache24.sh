#!/bin/bash

set -e -u -x

OMEROVER=omero

source settings.env

bash -eux step01_centos6_py27_deps.sh

bash -eux step02_centos6_py27_setup.sh
bash -eux step03_all_postgres.sh

cp settings.env omero-centos6py27.env step04_centos6_py27_${OMEROVER}.sh ~omero
su - omero -c "bash -eux step04_centos6_py27_${OMEROVER}.sh"

bash -eux step05_centos6_py27_apache24.sh

#If you don't want to use the init.d scripts you can start OMERO manually:
#su - omero -c "OMERO.server/bin/omero admin start"
#su - omero -c "OMERO.server/bin/omero web start"

bash -eux step06_centos6_daemon_no_web.sh

bash -eux step07_all_perms.sh

bash -eux step08_all_cron.sh

#service omero start
#service omero-web start
