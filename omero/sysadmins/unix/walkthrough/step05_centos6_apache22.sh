#!/bin/bash

cp setup_omero_apache22.sh ~omero
su - omero -c "bash -eux setup_omero_apache22.sh"

yum -y install httpd mod_wsgi

# See setup_omero_apache.sh for the apache config file creation

cp ~omero/OMERO.server/apache.conf.tmp /etc/httpd/conf.d/omero-web.conf

chkconfig httpd on
service httpd start

bash -eux setup_centos_selinux.sh
