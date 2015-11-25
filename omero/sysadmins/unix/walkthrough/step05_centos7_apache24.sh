#!/bin/bash

cp setup_omero_apache24.sh ~omero
su - omero -c "bash -eux setup_omero_apache24.sh"

yum -y install httpd mod_wsgi
yum clean all

# See setup_omero_apache.sh for the apache config file creation

cp ~omero/OMERO.server/apache.conf.tmp /etc/httpd/conf.d/omero-web.conf

rm -rf /run/httpd/* /tmp/httpd*

systemctl enable httpd.service
systemctl start httpd