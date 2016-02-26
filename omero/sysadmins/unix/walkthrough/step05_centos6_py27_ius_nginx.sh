#!/bin/bash

set -e -u -x

cat << EOF > /etc/yum.repos.d/nginx.repo
[nginx]
name=nginx repo
baseurl=http://nginx.org/packages/centos/\$releasever/\$basearch/
gpgcheck=0
enabled=1
EOF

#install nginx
yum -y install nginx

virtualenv -p /usr/bin/python2.7 /home/omero/omeroenv
set +u
source /home/omero/omeroenv/bin/activate
set -u
# install in virtualenv created in step01
/home/omero/omeroenv/bin/pip2.7 install --upgrade "gunicorn>=19.3"

deactivate
# See setup_omero*.sh for the nginx config file creation

#remove comment
mv /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.disabled
cp ~omero/OMERO.server/nginx.conf.tmp /etc/nginx/conf.d/omero-web.conf

service nginx start

bash -eux setup_centos_selinux.sh