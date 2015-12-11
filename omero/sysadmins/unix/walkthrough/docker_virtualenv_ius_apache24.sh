#!/bin/bash

set -e -u -x

#OMEROVER=omero
OMEROVER=omerodev

source settings.env

#install httpd 2.4
yum -y install httpd24u

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

# cannot use python27-mod_wsgi from ius since httpd2.2 is a dependency
# install via pip.
/home/omero/omeroenv/bin/pip2.7 install mod_wsgi-httpd
/home/omero/omeroenv/bin/pip2.7 install mod_wsgi

echo source \~omero/omero-centos6py27ius.env >> ~omero/.bashrc
cp settings.env omero-centos6py27ius.env step04_centos6_py27_ius_${OMEROVER}.sh ~omero

if [ $OMEROVER = omerodev ]; then
	/home/omero/omeroenv/bin/pip2.7 install omego
fi

su - omero -c "bash -eux step04_centos6_py27_ius_${OMEROVER}.sh"

cp settings.env ~omero

cp setup_omero_apache24.sh ~omero
su - omero -c "bash -eux setup_omero_apache24.sh"


# See setup_omero_apache.sh for the apache config file creation
cp ~omero/OMERO.server/apache.conf.tmp /etc/httpd/conf.d/omero-web.conf

# create wsgi.conf file
cat << EOF > /etc/httpd/conf.d/wsgi.conf
LoadModule wsgi_module /home/omero/omeroenv/lib64/python2.7/site-packages/mod_wsgi/server/mod_wsgi-py27.so
EOF

chkconfig httpd on
service httpd start
bash -eux step07_all_perms.sh