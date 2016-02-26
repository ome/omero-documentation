#!/bin/bash

apt-get -y install nginx

pip install "gunicorn>=19.3"

# See setup_omero*.sh for the nginx config file creation

cp ~omero/OMERO.server/nginx.conf.tmp /etc/nginx/sites-available/omero-web
rm /etc/nginx/sites-enabled/default
ln -s /etc/nginx/sites-available/omero-web /etc/nginx/sites-enabled/

service nginx start
