#!/bin/bash

set -e -u -x

DISTRO=
WEBSERVER=nginx
OMEROVER=omero50

for arg in "$@"; do
	case "$arg" in
	centos6|ubuntu1404)
		DISTRO="$arg"
		;;
	nginx|apache)
		WEBSERVER="$arg"
		;;
	omero50|omero51)
		OMEROVER="$arg"
		;;
	*)
		echo "Unknown option: $arg";
		exit 1
	esac
done

if [ -z "$DISTRO" ]; then
	echo "No distro specified"
	exit 1
fi

source settings.env

if [ $DISTRO = centos6 ]; then
	bash -eux dependencies-centos6.sh
else
	bash -eux dependencies-ubuntu1404.sh
fi

bash -eux system_setup.sh
bash -eux setup_postgres.sh

cp settings.env setup_$OMEROVER.sh ~omero
if [ $WEBSERVER = apache ]; then
	cp setup_omero_apache.sh ~omero
fi

su - omero -c "bash -eux setup_$OMEROVER.sh"

if [ $DISTRO = centos6 ]; then
	if [ $WEBSERVER = nginx ]; then
		bash -eux setup_nginx_centos6.sh
		bash -eux setup_nginx_centos6_selinux.sh
	else
		su - omero -c "bash -eux setup_omero_apache.sh"
		bash -eux setup_apache_centos6.sh
	fi
else
	if [ $WEBSERVER = nginx ]; then
		bash -eux setup_nginx_ubuntu1404.sh
	fi
fi

#If you don't want to use the init.d scripts you can start OMERO manually:
#su - omero -c "OMERO.server/bin/omero admin start"
#su - omero -c "OMERO.server/bin/omero web start"

if [ $DISTRO = centos6 ]; then
	bash -eux setup_omero_daemon_centos6.sh
else
	bash -eux setup_omero_daemon_ubuntu1404.sh
fi

bash -eux setup_cron.sh

#service omero start
#service omero-web start
