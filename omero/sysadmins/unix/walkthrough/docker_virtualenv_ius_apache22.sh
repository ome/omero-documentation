#!/bin/bash

set -e -u -x

#OMEROVER=omero
OMEROVER=omerodev

source settings.env

#install Apache 2.2
yum -y install httpd

# install mod_wsgi compiled against 2.7
yum -y install python27-mod_wsgi

#Create virtual env.
# -p only require if it has been installed with 2.6
virtualenv -p /usr/bin/python2.7 /home/omero/omeroenv
set +u
source /home/omero/omeroenv/bin/activate
set -u
/home/omero/omeroenv/bin/pip install --upgrade pip

# Cap Pillow version due to a limitation in OMERO.figure with v3.0.0
/home/omero/omeroenv/bin/pip2.7 install "Pillow<3.0"

# install omero dependencies
/home/omero/omeroenv/bin/pip2.7 install numpy matplotlib

# Django
/home/omero/omeroenv/bin/pip2.7 install "Django>=1.8,<1.9"

echo source \~omero/omero-centos6py27ius.env >> ~omero/.bashrc
cp settings.env omero-centos6py27ius.env step04_centos6_py27_ius_${OMEROVER}.sh ~omero

if [ $OMEROVER = omerodev ]; then
	/home/omero/omeroenv/bin/pip2.7 install omego
fi

su - omero -c "bash -eux step04_centos6_py27_ius_${OMEROVER}.sh"

cp settings.env ~omero

cp setup_omero_apache22.sh ~omero
su - omero -c "bash -eux setup_omero_apache22.sh"

# See setup_omero_apache.sh for the apache config file creation
cp ~omero/OMERO.server/apache.conf.tmp /etc/httpd/conf.d/omero-web.conf


chkconfig httpd on
service httpd start
bash -eux step07_all_perms.sh