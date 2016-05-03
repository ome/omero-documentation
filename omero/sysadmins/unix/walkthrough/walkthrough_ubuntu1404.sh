#!/bin/bash
set -e -u -x
source settings.env

#start-step01: As root, install dependencies

apt-get update

# installed for convenience
apt-get -y install unzip wget

# install Java
apt-get -y install software-properties-common
add-apt-repository -y ppa:openjdk-r/ppa
apt-get update
apt-get -y install openjdk-8-jre

# install dependencies

apt-get update
apt-get -y install \
	unzip \
	wget \
	python-{matplotlib,numpy,pip,scipy,tables,virtualenv}

# require to install Pillow
apt-get -y install \
	libtiff5-dev \
	libjpeg8-dev \
	zlib1g-dev \
	libfreetype6-dev \
	liblcms2-dev \
	libwebp-dev \
	tcl8.6-dev \
	tk8.6-dev

pip install --upgrade pip

# upgrade required since pillow is already installed
pip install --upgrade -r requirements.txt
# install Ice
#start-recommended-ice
apt-get -y install ice-services python-zeroc-ice
#end-recommended-ice
#start-supported-ice
apt-get -y install db5.3-util
apt-get -y install libssl-dev libbz2-dev libmcpp-dev libdb++-dev libdb-dev

apt-key adv --keyserver keyserver.ubuntu.com --recv 5E6DA83306132997
apt-add-repository "deb http://zeroc.com/download/apt/ubuntu`lsb_release -rs` stable main"
apt-get update
apt-get -y install zeroc-ice-all-runtime zeroc-ice-all-dev

pip install "zeroc-ice>3.5,<3.7"
#end-supported-ice


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
#start-release-ice35
cd ~omero
SERVER=http://downloads.openmicroscopy.org/latest/omero5.2/server-ice35.zip
wget $SERVER
unzip -q OMERO.server*
#end-release-ice35
#start-release-ice36
cd ~omero
SERVER=http://downloads.openmicroscopy.org/latest/omero5.2/server-ice36.zip
wget $SERVER -O OMERO.server-ice36.zip
unzip -q OMERO.server*
#end-release-ice36
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
# require to install more recent version of nginx
# w/o the version installed is 1.4.6
add-apt-repository -y ppa:nginx/stable

apt-get update
apt-get -y install nginx

pip install -r ~omero/OMERO.server/share/web/requirements-py27-nginx.txt

# set up as the omero user.
su - omero -c "bash -eux setup_omero_nginx.sh"

cp ~omero/OMERO.server/nginx.conf.tmp /etc/nginx/sites-available/omero-web
rm /etc/nginx/sites-enabled/default
ln -s /etc/nginx/sites-available/omero-web /etc/nginx/sites-enabled/

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

# Optionally restrict access to the OMERO data directory
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
