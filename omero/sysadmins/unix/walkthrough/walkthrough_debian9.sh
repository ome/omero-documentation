#!/bin/bash
set -e -u -x
source settings.env

#start-step01: As root, install dependencies

apt-get update

# installed for convenience
apt-get -y install unzip wget bc

# install Java
apt-get -y install openjdk-8-jre-headless

# install dependencies

apt-get -y install \
	python-{pip,pillow,numpy,tables,virtualenv,yaml,jinja2}

pip install --upgrade pip
# install Ice
#start-recommended-ice
apt-get -y install libssl-dev libbz2-dev libmcpp-dev libdb++-dev libdb-dev libdb-java
apt-get -y install zeroc-ice-all-runtime
pip install "zeroc-ice>3.5,<3.7"
#end-recommended-ice


# install Postgres
apt-get -y install postgresql

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
cp settings.env step04_all_omero.sh setup_omero_db.sh ~omero 
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
#start-patch-openssl
#start-seclevel
sed -i 's/\("IceSSL.Ciphers".*ADH\)/\1:@SECLEVEL=0/' OMERO.server/lib/python/omero/clients.py OMERO.server/etc/templates/grid/templates.xml
#end-seclevel
#end-patch-openssl

#start-step05: As root, install Nginx
#start-nginx
apt-get -y install nginx
pip install -r $file
#start-configure-nginx: As the omero system user, configure OMERO.web
OMERO.server/bin/omero config set omero.web.application_server wsgi-tcp
OMERO.server/bin/omero web config nginx --http "$OMERO_WEB_PORT" > OMERO.server/nginx.conf.tmp
#end-configure-nginx
mv /etc/nginx/sites-available/default /etc/nginx/sites-available/default.disabled
cp ~omero/OMERO.server/nginx.conf.tmp /etc/nginx/conf.d/omero-web.conf

service nginx start
#end-nginx

#end-step05

#start-step06: As root, run the scripts to start OMERO and OMERO.web automatically
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
