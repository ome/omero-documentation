#!/bin/bash
set -e -u -x


# install Java
dnf -y install java-11-openjdk

# install dependencies
dnf -y install python unzip bzip2 wget bc openssl
#end-step01
# install Ice
#start-recommended-ice
if grep -q "Rocky" /etc/redhat-release; then
  dnf -y install 'dnf-command(config-manager)'
  dnf config-manager --set-enabled crb
fi
if grep -q "Red Hat" /etc/redhat-release; then
  subscription-manager repos --enable codeready-builder-for-rhel-9-$(arch)-rpms
fi
dnf -y install expat libdb-cxx

cd /tmp
wget https://github.com/glencoesoftware/zeroc-ice-rhel9-x86_64/releases/download/20230928/Ice-3.6.5-rhel9-x86_64.tar.gz
tar xf Ice-3.6.5-rhel9-x86_64.tar.gz
mv Ice-3.6.5 /opt/ice-3.6.5
echo /opt/ice-3.6.5/lib64 > /etc/ld.so.conf.d/ice-x86_64.conf
ldconfig
#end-recommended-ice


# install Postgres
dnf install -y https://download.postgresql.org/pub/repos/yum/reporpms/EL-9-x86_64/pgdg-redhat-repo-latest.noarch.rpm
dnf -qy module disable postgresql
dnf -y install postgresql15-server postgresql15
PGSETUP_INITDB_OPTIONS=--encoding=UTF8  /usr/pgsql-15/bin/postgresql-15-setup initdb

sed -i.bak -re 's/^(host.*)ident/\1md5/' /var/lib/pgsql/15/data/pg_hba.conf
sed -i 's/ ident/ trust/g' /var/lib/pgsql/15/data/pg_hba.conf
systemctl start postgresql
systemctl enable postgresql
#end-step01

#start-step02: As root, create a local omero-server system user and directory for the OMERO repository
useradd -mr omero-server
# Give a password to the omero user
# e.g. passwd omero-server
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
# Create a virtual env
python3 -mvenv $VENV_SERVER

# Upgrade pip
$VENV_SERVER/bin/pip install --upgrade pip

# Install the Ice Python binding
$VENV_SERVER/bin/pip install https://github.com/glencoesoftware/zeroc-ice-py-rhel9-x86_64/releases/download/20230830/zeroc_ice-3.6.5-cp39-cp39-linux_x86_64.whl
# Install server dependencies
$VENV_SERVER/bin/pip install omero-server
#end-step03bis

#start-step04-pre: As root, download the OMERO.server
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
#start-seclevel
omero certificates
#end-seclevel


#start-step06: As root, run the scripts to start OMERO automatically
cp omero-server-init.d /etc/init.d/omero-server
chmod a+x /etc/init.d/omero-server

update-rc.d -f omero-server remove
update-rc.d -f omero-server defaults 98 02
#end-step06

#start-step07: As root, secure OMERO
chmod go-rwx $OMERODIR/etc $OMERODIR/var

# Optionally restrict access to the OMERO data directory
# chmod go-rwx "$OMERO_DATA_DIR"
#end-step07
#start-step08: As root, configure
cp omero-server-systemd.service /etc/systemd/system/omero-server.service

systemctl daemon-reload

systemctl enable omero-server.service
firewall-cmd --zone=public --add-port=4064/tcp --permanent
firewall-cmd --reload
#end-step08
