#!/bin/bash

set -e -u -x

OMEROVER=${OMEROVER:-omero}
WEBAPPS=${WEBAPPS:-false}

source settings.env

bash -eux step01_centos6_py27_ius_deps.sh
bash -eux step02_centos6_py27_ius_setup.sh

bash -eux step03_all_postgres.sh

OMEROVER=${OMEROVER} bash -eux step03_centos6_py27_ius_virtualenv_deps.sh

cp settings.env omero-centos6py27ius.env step04_centos6_py27_ius_${OMEROVER}.sh ~omero

su - omero -c "bash -eux step04_centos6_py27_ius_${OMEROVER}.sh"

if [ $WEBAPPS = true ]; then
	PY_ENV=py27_ius bash -eux step05_1_all_webapps.sh
fi

bash -eux step05_centos6_py27_ius_apache22.sh

#If you don't want to use the init.d scripts you can start OMERO manually:
#su - omero -c "OMERO.server/bin/omero admin start"
#su - omero -c "OMERO.server/bin/omero web start"

bash -eux step06_centos6_daemon.sh

bash -eux step07_all_perms.sh

bash -eux step08_all_cron.sh

#service omero start
#service omero-web start