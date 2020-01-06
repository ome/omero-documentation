#!/bin/bash
set -e -u -x

#start-step01: As root, install dependencies
apt-get update

apt-get -y install unzip wget bc

# to be installed if daily cron tasks are configured
apt-get -y install cron

# install Java
apt-get -y install software-properties-common
add-apt-repository ppa:openjdk-r/ppa
apt-get update -q
apt-get install -y openjdk-11-jre

# install dependencies
apt-get update
apt-get -y install \
	unzip \
	wget \
	python3 \
	python3-venv
#end-step01
# install Ice
#start-recommended-ice
apt-get -y install software-properties-common
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 5E6DA83306132997
apt-add-repository "deb http://zeroc.com/download/apt/ubuntu`lsb_release -rs` stable main"
apt-get update
apt-get -y install zeroc-ice-all-runtime
#end-recommended-ice


# install Postgres
apt-get -y install apt-transport-https
add-apt-repository -y "deb https://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main 11"
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
apt-get update
apt-get -y install postgresql-11
sed -i.bak -re 's/^(host.*)ident/\1md5/' /etc/postgresql/11/main/pg_hba.conf
service postgresql start
#end-step01

#start-step02: As root, create a local omero-server system user and directory for the OMERO repository
useradd -mr omero-server
# Give a password to the omero user
# e.g. passwd omero
chmod a+X ~omero-server

mkdir -p "$OMERO_DATA_DIR"
chown omero-server "$OMERO_DATA_DIR"
#end-step02
#start-step03: As root, create a database user and a database
echo "CREATE USER $OMERO_DB_USER PASSWORD '$OMERO_DB_PASS'" | su - postgres -c psql
su - postgres -c "createdb -E UTF8 -O '$OMERO_DB_USER' '$OMERO_DB_NAME'"

psql -P pager=off -h localhost -U "$OMERO_DB_USER" -l
#end-step03

#start-step03bis: As root, create a virtual env and install dependencies
# Create a virtual env and activate it
python3 -mvenv $VENV_SERVER

# Install the Ice Python binding
$VENV_SERVER/bin/pip install https://github.com/ome/zeroc-ice-py-ubuntu1604/releases/download/0.2.0/zeroc_ice-3.6.5-cp35-cp35m-linux_x86_64.whl
#end-step03bis

#start-step04-pre: As root, install omero-py and download the OMERO.server
# Install omero-py
$VENV_SERVER/bin/pip install "omero-py>=5.6.dev4"
#start-release-ice36
cd /opt/omero/server
SERVER=https://downloads.openmicroscopy.org/omero/5.6/server-ice36.zip
wget -q $SERVER -O OMERO.server-ice36.zip
unzip -q OMERO.server*
#end-release-ice36
# change ownership of the folder
chown -R omero-server OMERO.server-*
ln -s OMERO.server-*/ OMERO.server
#end-step04-pre

#start-step04: As the omero-server system user, configure it
#start-copy-omeroscript
cp settings.env step04_all_omero.sh setup_omero_db.sh ~omero 
#end-copy-omeroscript
omero config set omero.data.dir "$OMERO_DATA_DIR"
omero config set omero.db.name "$OMERO_DB_NAME"
omero config set omero.db.user "$OMERO_DB_USER"
omero config set omero.db.pass "$OMERO_DB_PASS"
omero db script -f $OMERODIR/db.sql --password "$OMERO_ROOT_PASS"
psql -h localhost -U "$OMERO_DB_USER" "$OMERO_DB_NAME" < $OMERODIR/db.sql
#end-step04


#start-step06: As root, run the scripts to start OMERO automatically
#end-step06

#start-step07: As root, secure OMERO
chmod go-rwx $OMERODIR/etc $OMERODIR/var

# Optionally restrict access to the OMERO data directory
# chmod go-rwx "$OMERO_DATA_DIR"
#end-step07
