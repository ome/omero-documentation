#!/bin/bash

cp setup_omero_apache24.sh ~omero
su - omero -c "bash -eux setup_omero_apache24.sh"

yum -y install httpd24-httpd python27-mod_wsgi

# See setup_omero_apache.sh for the apache config file creation

cp ~omero/OMERO.server/apache.conf.tmp /opt/rh/httpd24/root/etc/httpd/conf.d/omero-web.conf

chkconfig httpd24-httpd on
service httpd24-httpd start

bash -eux setup_centos_selinux.sh
