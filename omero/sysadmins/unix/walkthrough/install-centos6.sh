#!/bin/bash

set -e -u -x

source settings.env

bash -eux dependencies-centos6.sh

bash -eux system_setup.sh
bash -eux setup_postgres.sh

cp settings.env setup_omero_ice35.sh ~omero
su - omero -c "bash -eux setup_omero_ice35.sh"

bash -eux setup_nginx_centos6.sh
bash -eux setup_nginx_centos6_selinux.sh

#If you don't want to use the init.d scripts you can start OMERO manually:
#su - omero -c "OMERO.server/bin/omero admin start"
#su - omero -c "OMERO.server/bin/omero web start"

bash -eux setup_omero_daemon_centos6.sh

#service omero start
#service omero-web start
