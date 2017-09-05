#!/bin/bash
set -e -u -x
source settings.env
source settings-web.env

#start-step01: As root, install dependencies

apt-get update

# installed for convenience
apt-get -y install unzip wget bc

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
	python-{pip,tables,virtualenv,yaml,jinja2}

pip install --upgrade pip

#start-web-dependencies
apt-get -y install zlib1g-dev
apt-get -y install python-{pillow,numpy}
#end-web-dependencies
# install Ice
#start-recommended-ice
apt-get -y install db5.3-util
apt-get -y install libssl-dev libbz2-dev libmcpp-dev libdb++-dev libdb-dev

apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 5E6DA83306132997
apt-add-repository "deb http://zeroc.com/download/apt/ubuntu`lsb_release -rs` stable main"
apt-get update
apt-get -y install zeroc-ice-all-runtime zeroc-ice-all-dev

pip install "zeroc-ice>3.5,<3.7"
#end-recommended-ice
#start-supported-ice
apt-get -y install ice-services python-zeroc-ice
#end-supported-ice


# install Postgres
apt-get -y install apt-transport-https
add-apt-repository -y "deb https://apt.postgresql.org/pub/repos/apt/ trusty-pgdg main 9.6"
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
apt-get update
apt-get -y install postgresql-9.6
service postgresql start

#end-step01

#start-step02: As root, create an omero system user and directory for the OMERO repository
useradd -m omero
chmod a+X ~omero

mkdir -p "$OMERO_DATA_DIR"
chown omero "$OMERO_DATA_DIR"
#end-step02

#start-step03: As root, create a database user and a database

echo "CREATE USER $OMERO_DB_USER PASSWORD '$OMERO_DB_PASS'" | su - postgres -c psql
su - postgres -c "createdb -E UTF8 -O '$OMERO_DB_USER' '$OMERO_DB_NAME'"

psql -P pager=off -h localhost -U "$OMERO_DB_USER" -l
#end-step03

#start-step04: As the omero system user, install the OMERO.server
#start-copy-omeroscript
cp settings.env settings-web.env step04_all_omero.sh setup_omero_db.sh ~omero 
#end-copy-omeroscript
#start-release-ice35
/home/omero/omeroenv/bin/omego download --ice 3.5 --branch 5.2 server
#end-release-ice35
#start-release-ice36
cd ~omero
SERVER=http://downloads.openmicroscopy.org/latest/omero5.3/server-ice36.zip
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

#start-step05: As omero, install OMERO.web dependencies
#web-requirements-recommended-start
pip install -r OMERO.server/share/web/requirements-py27.txt
#web-requirements-recommended-end
#start-configure-nginx: As the omero system user, configure OMERO.web
OMERO.server/bin/omero config set omero.web.application_server wsgi-tcp
OMERO.server/bin/omero web config nginx --http "$OMERO_WEB_PORT" > OMERO.server/nginx.conf.tmp
#end-configure-nginx
# As root, install nginx
#start-nginx-install
# required to install more recent version of nginx
# without this, the version installed is 1.4.6
add-apt-repository -y ppa:nginx/stable

apt-get update
apt-get -y install nginx
#end-nginx-install
#start-nginx-admin
cp OMERO.server/nginx.conf.tmp /etc/nginx/sites-available/omero-web
rm /etc/nginx/sites-enabled/default
ln -s /etc/nginx/sites-available/omero-web /etc/nginx/sites-enabled/

service nginx start
#end-nginx-admin

#end-step05

#start-step06: As root, run the scripts to start OMERO and OMERO.web automatically
#end-step06

#start-step07: As root, secure OMERO
chmod go-rwx OMERO.server/etc OMERO.server/var

# Optionally restrict access to the OMERO data directory
# chmod go-rwx "$OMERO_DATA_DIR"
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
