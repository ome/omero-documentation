#!/bin/bash

set -e -u -x

# Full path of the current directory containing the install scripts
INSTALL_SCRIPTS=$(readlink -f $(dirname $0))

source settings.env

bash -eux dependencies-ubuntu1404.sh

bash -eux system_setup.sh
bash -eux setup_postgres.sh

cp settings.env setup_omero_ice35.sh ~omero
su - omero -c "bash -eux setup_omero_ice35.sh"

bash -eux setup_nginx_ubuntu1404.sh

#If you don't want to use the init.d scripts you can start OMERO manually:
#su - omero -c "OMERO.server/bin/omero admin start"
#su - omero -c "OMERO.server/bin/omero web start"

bash -eux setup_omero_daemon_ubuntu1404.sh

#service omero start
#service omero-web start
