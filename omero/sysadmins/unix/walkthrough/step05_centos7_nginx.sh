#!/bin/bash

yum -y --enablerepo=cr install nginx

pip install "gunicorn>=19.3"

# See setup_omero*.sh for the nginx config file creation

sed -i.bak -re 's/( default_server.*)/; #\1/' /etc/nginx/nginx.conf
cp ~omero/OMERO.server/nginx.conf.tmp /etc/nginx/conf.d/omero-web.conf

systemctl enable nginx
systemctl start nginx

bash -eux setup_centos_selinux.sh
