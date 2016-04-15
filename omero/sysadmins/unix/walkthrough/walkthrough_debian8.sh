#!/bin/bash
set -e -u -x
source settings.env

#start-step01: As root, install dependencies

apt-get update

# installed for convenience
apt-get -y install unzip wget

# install Java
echo 'deb http://httpredir.debian.org/debian jessie-backports main' > /etc/apt/sources.list.d/jessie-backports.list
apt-get update
apt-get -y install openjdk-8-jre-headless=8u72-b15-1~bpo8+1 ca-certificates-java=20140324

# install Ice
apt-get -y install ice-services python-zeroc-ice


apt-get -y install \
	python-{matplotlib,numpy,pip,scipy,tables,virtualenv}

# require to install Pillow
apt-get -y install \
	libtiff5-dev \
	libjpeg62-turbo-dev \
	zlib1g-dev \
	libfreetype6-dev \
	liblcms2-dev \
	libwebp-dev \
	tcl8.6-dev \
	tk8.6-dev

pip install --upgrade pip

pip install -r requirements.txt

# install Postgres
apt-get -y install apt-transport-https
add-apt-repository -y "deb https://apt.postgresql.org/pub/repos/apt/ trusty-pgdg main"
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
apt-get update
apt-get -y install postgresql-9.4
service postgresql start

#end-step01

#start-step02: As root, create an omero system user and directory for the OMERO repository
useradd -m omero
chmod a+X ~omero

mkdir -p "$OMERO_DATA_DIR"
chown omero "$OMERO_DATA_DIR"
#end-step02

#start-step03: As root, create a database user and a database

echo "CREATE USER $OMERO_DB_USER PASSWORD '$OMERO_DB_PASS'" | \
    su - postgres -c psql
su - postgres -c "createdb -E UTF8 -O '$OMERO_DB_USER' '$OMERO_DB_NAME'"

psql -P pager=off -h localhost -U "$OMERO_DB_USER" -l
#end-step03

#start-step04: As the omero system user, install the OMERO.server
#start-copy-omeroscript
cp settings.env omero-.env step04_all_omero.sh setup_omero_db.sh ~omero 
#end-copy-omeroscript
virtualenv /home/omero/omeroenv
/home/omero/omeroenv/bin/pip install omego==0.3.0
/home/omero/omeroenv/bin/omego download --branch latest server

ln -s OMERO.server-*/ OMERO.server
OMERO.server/bin/omero config set omero.data.dir "$OMERO_DATA_DIR"
OMERO.server/bin/omero config set omero.db.name "$OMERO_DB_NAME"
OMERO.server/bin/omero config set omero.db.user "$OMERO_DB_USER"
OMERO.server/bin/omero config set omero.db.pass "$OMERO_DB_PASS"
OMERO.server/bin/omero db script -f OMERO.server/db.sql --password "$OMERO_ROOT_PASS"
psql -h localhost -U "$OMERO_DB_USER" "$OMERO_DB_NAME" < OMERO.server/db.sql
#end-step04

#start-step05: As root, install a Web server: Nginx or Apache
#start-nginx
echo "deb http://nginx.org/packages/debian/ jessie nginx" >> /etc/apt/sources.list
wget http://nginx.org/keys/nginx_signing.key
apt-key add nginx_signing.key
rm nginx_signing.key
apt-get update
apt-get -y install nginx

pip install -r ~omero/OMERO.server/share/web/requirements-py27-nginx.txt

# set up as the omero user.
su - omero -c "bash -eux setup_omero_nginx.sh"

mv /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.disabled
cp ~omero/OMERO.server/nginx.conf.tmp /etc/nginx/conf.d/omero-web.conf

service nginx start
#end-nginx

#start-apache
#start-copy
cp setup_omero_apache24.sh ~omero
#end-copy
#start-configure-apache: As the omero system user, configure OMERO.web
OMERO.server/bin/omero config set omero.web.application_server wsgi
OMERO.server/bin/omero web config apache24 --http "$OMERO_WEB_PORT" > OMERO.server/apache.conf.tmp
OMERO.server/bin/omero web syncmedia
#end-configure-apache
#start-apache-install
apt-get -y install apache2 libapache2-mod-wsgi

# Install OMERO.web requirements
pip install -r ~omero/OMERO.server/share/web/requirements-py27-apache.txt

# Modify the default value set for the ``WSGISocketPrefix`` directive in ``apache.conf.tmp``
sed -i -r -e 's|(WSGISocketPrefix run/wsgi)|#\1|' -e 's|# (WSGISocketPrefix /var/run/wsgi)|\1|' ~omero/OMERO.server/apache.conf.tmp
cp ~omero/OMERO.server/apache.conf.tmp /etc/apache2/sites-available/omero-web.conf
a2dissite 000-default.conf
a2ensite omero-web.conf

service apache2 start
#end-apache-install
#end-apache
#end-step05

#start-step06: As root, run the scripts to start OMERO and OMERO.web automatically

cp omero-init.d /etc/init.d/omero
chmod a+x /etc/init.d/omero

cp omero-web-init.d /etc/init.d/omero-web
chmod a+x /etc/init.d/omero-web

update-rc.d -f omero remove
update-rc.d -f omero defaults 98 02
update-rc.d -f omero-web remove
update-rc.d -f omero-web defaults 98 02
#end-step06

#start-step07: As root, secure OMERO
chmod go-rwx ~omero/OMERO.server/etc ~omero/OMERO.server/var

#Optionally restrict accesss to the OMERO data directory
#chmod go-rwx "$OMERO_DATA_DIR"
#end-step07

#start-step08: As root, perform regular tasks
#start-omeroweb-cron
OMERO_USER=omero
OMERO_SERVER=/home/omero/OMERO.server
su - ${OMERO_USER} -c "${OMERO_SERVER}/bin/omero web clearsessions"
#end-omeroweb-cron
#Copy omero-web-cron into the appropriate location
#start-copy-omeroweb-cron

cp omero-web-cron /etc/cron.daily/omero-web
chmod a+x /etc/cron.daily/omero-web
#end-copy-omeroweb-cron
#end-step08
