#!/bin/bash
set -e -u -x
source settings.env
source settings-web.env

#start-step01: As root, install dependencies
apt-get update

# installed for convenience
apt-get -y install unzip wget bc

# to be installed if recommended/suggested is false
apt-get -y install cron

# install Java
apt-get -y install openjdk-8-jre-headless

# install dependencies

apt-get -y install\
    python3 \
    python3-venv

# to be installed if recommended/suggested is false
apt-get -y install python3-setuptools python3-wheel
#start-web-dependencies
apt-get -y install zlib1g-dev libjpeg-dev
#end-web-dependencies
#end-step01
# install Ice
#start-recommended-ice
apt-get -y install zeroc-ice-all-runtime
#end-recommended-ice


# install Postgres
apt-get install -y gnupg
echo "deb [arch=amd64] http://apt.postgresql.org/pub/repos/apt/ stretch-pgdg main" > /etc/apt/sources.list.d/pgdg.list
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
apt-get update
apt-get install -y postgresql-10
service postgresql start
#end-step01

#start-step02: As root, create an omero system user and directory for the OMERO repository
useradd -m omero
# Give a password to the omero user
# e.g. passwd omero
chmod a+X ~omero

mkdir -p "$OMERO_DATA_DIR"
chown omero "$OMERO_DATA_DIR"
#end-step02
#start-step03: As root, create a database user and a database
echo "CREATE USER $OMERO_DB_USER PASSWORD '$OMERO_DB_PASS'" | su - postgres -c psql
su - postgres -c "createdb -E UTF8 -O '$OMERO_DB_USER' '$OMERO_DB_NAME'"

psql -P pager=off -h localhost -U "$OMERO_DB_USER" -l
#end-step03

#start-step03bis: As root, create a virtual env and install dependencies
# Create a virtual env and activate it
VENV_SERVER=${VENV_SERVER:-/opt/omero/server/venv}
python3 -mvenv $VENV_SERVER
. $VENV_SERVER/bin/activate

# Install the Ice Python binding
pip install https://github.com/ome/zeroc-ice-py-debian9/releases/download/0.2.0/zeroc_ice-3.6.5-cp35-cp35m-linux_x86_64.whl
#end-step03bis

#start-step04-pre: As root, install omero-py
# Install omero-py
pip install "omero-py>=5.6.dev4"
#end-step04-pre

#start-step04: As the omero user, download the OMERO.server and configure it
#start-copy-omeroscript
cp settings.env settings-web.env step04_all_omero.sh setup_omero_db.sh ~omero 
#end-copy-omeroscript
#start-release-ice36
cd /home/omero
#SERVER=https://downloads.openmicroscopy.org/latest/omero5.6/server-ice36.zip
SERVER=https://downloads.openmicroscopy.org/omero/5.6.0-m2/artifacts/OMERO.server-5.6.0-m2-ice36-b126.zip
wget -q $SERVER -O OMERO.server-ice36.zip
unzip -q OMERO.server*
#end-release-ice36
ln -s OMERO.server-*/ OMERO.server
omero config set omero.data.dir "$OMERO_DATA_DIR"
omero config set omero.db.name "$OMERO_DB_NAME"
omero config set omero.db.user "$OMERO_DB_USER"
omero config set omero.db.pass "$OMERO_DB_PASS"
omero db script -f OMERO.server/db.sql --password "$OMERO_ROOT_PASS"
psql -h localhost -U "$OMERO_DB_USER" "$OMERO_DB_NAME" < OMERO.server/db.sql
#end-step04
#start-patch-openssl
#start-seclevel
omero config set omero.glacier2.IceSSL.Ciphers HIGH:ADH:@SECLEVEL=0
#end-seclevel
#end-patch-openssl

#start-step05: As omero, install OMERO.web dependencies

#start-configure-nginx: As the omero system user, configure OMERO.web
omero config set omero.web.application_server wsgi-tcp
omero web config nginx --http "$WEBPORT" > /home/omero/OMERO.server/nginx.conf.tmp
#end-configure-nginx
# As root, install nginx
#start-nginx-install
apt-get -y install nginx gunicorn
#end-nginx-install
#start-nginx-admin
mv /etc/nginx/sites-available/default /etc/nginx/sites-available/default.disabled
cp /home/omero/OMERO.server/nginx.conf.tmp /etc/nginx/conf.d/omero-web.conf

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
SETTINGS=/home/omero/settings.env
su - ${OMERO_USER} -c ". ${SETTINGS} omero web clearsessions"
#end-omeroweb-cron
#Copy omero-web-cron into the appropriate location
#start-copy-omeroweb-cron

cp omero-web-cron /etc/cron.daily/omero-web
chmod a+x /etc/cron.daily/omero-web
#end-copy-omeroweb-cron
#end-step08
