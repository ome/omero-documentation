#!/bin/bash

set -e -u -x

cat << EOF > /etc/yum.repos.d/nginx.repo
[nginx]
name=nginx repo
baseurl=http://nginx.org/packages/centos/\$releasever/\$basearch/
gpgcheck=0
enabled=1
EOF

OMEROVER=omero
#OMEROVER=omerodev

source settings.env

#install nginx
yum -y install nginx

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

/home/omero/omeroenv/bin/pip2.7 install gunicorn

echo source \~omero/omero-centos6py27ius.env >> ~omero/.bashrc
cp settings.env omero-centos6py27ius.env step04_centos6_py27_ius_${OMEROVER}.sh ~omero

if [ $OMEROVER = omerodev ]; then
	/home/omero/omeroenv/bin/pip2.7 install omego
fi
su - omero -c "bash -eux step04_centos6_py27_ius_${OMEROVER}.sh"

# See setup_omero*.sh for the nginx config file creation
su - omero -c "OMERO.server/bin/omero config set omero.web.application_server wsgi-tcp"
su - omero -c "OMERO.server/bin/omero web config nginx --http "$OMERO_WEB_PORT" > OMERO.server/nginx.conf.tmp"

#remove comment
mv /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.disabled
cp ~omero/OMERO.server/nginx.conf.tmp /etc/nginx/conf.d/omero-web.conf

service nginx start

bash -eux setup_centos6_selinux.sh
bash -eux step07_all_perms.sh