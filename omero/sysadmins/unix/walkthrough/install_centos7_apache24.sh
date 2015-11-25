#!/bin/bash

set -e -u -x

OMEROVER=omero

source settings.env

bash -eux step01_centos7_deps.sh

bash -eux step02_all_setup.sh
bash -eux step03_all_postgres.sh

cp settings.env step04_all_$OMEROVER.sh ~omero
su - omero -c "bash -eux step04_all_$OMEROVER.sh"

bash -eux step05_centos7_apache24.sh

#If you don't want to use the systemd scripts you can start OMERO manually:
#su - omero -c "OMERO.server/bin/omero admin start"
#su - omero -c "OMERO.server/bin/omero web start"

bash -eux step06_centos7_daemon.sh

#systemctl start omero.service
#systemctl start omero-web.service