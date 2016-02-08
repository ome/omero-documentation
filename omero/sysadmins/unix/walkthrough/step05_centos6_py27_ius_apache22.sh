#!/bin/bash

cp setup_omero_apache22.sh ~omero

su - omero -c "bash -eux setup_omero_apache22.sh"

#install Apache 2.2
yum -y install httpd

# install mod_wsgi compiled against 2.7
yum -y install python27-mod_wsgi

# Add virtual env python to the python-path parameter of the WSGIDaemonProcess directive
sed -i 's/\(python-path\=\)/\1\/home\/omero\/omeroenv\/lib64\/python2.7\/site-packages:/' ~omero/OMERO.server/apache.conf.tmp
# See setup_omero_apache.sh for the apache config file creation
cp ~omero/OMERO.server/apache.conf.tmp /etc/httpd/conf.d/omero-web.conf

chkconfig httpd on
service httpd start

bash -eux setup_centos_selinux.sh