#!/usr/bin/env bash
# Main OMERO installation script

set -e
set -u
set -x

export PATH=/usr/local/bin:/usr/local/opt/python/libexec/bin:$PATH
export OMERO_DATA_DIR=${OMERO_DATA_DIR:-~/OMERO.data}
export ROOT_PASSWORD=${ROOT_PASSWORD:-omero_root_password}
export ICE=${ICE:-3.6}
export HTTPPORT=${HTTPPORT:-8080}
export LANG=${LANG:-en_US.UTF-8}
export LANGUAGE=${LANGUAGE:-en_US:en}

###################################################################
# OMERO installation
###################################################################

# Install OMERO
OMERO_PYTHONPATH=$(brew --prefix omero53)/lib/python
brew install omero53 --with-nginx --with-cpp


export PYTHONPATH=$OMERO_PYTHONPATH
VERBOSE=1 brew test omero53

# Install OMERO Python dependencies
pip install -r $(brew --prefix omero53)/share/web/requirements-py27-all.txt
cd /usr/local
bash bin/omero_python_deps

# Set additional environment variables
export ICE_CONFIG=$(brew --prefix omero53)/etc/ice.config

# Reinitialize PSQL cluster to fix missing directories on OSX 10.11
rm -rf /usr/local/var/postgres
initdb -E UTF8 /usr/local/var/postgres

# Start PostgreSQL
pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log -w start

# Create user and database
createuser -w -D -R -S db_user
createdb -E UTF8 -O db_user omero_database
psql -h localhost -U db_user -l

# Set database
omero config set omero.db.name omero_database
omero config set omero.db.user db_user
omero config set omero.db.pass db_password

# Run DB script
omero db script --password $ROOT_PASSWORD -f - | psql -h localhost -U db_user omero_database

# Stop PostgreSQL
pg_ctl -D /usr/local/var/postgres -m fast stop

# Set up the data directory
if [ -d "$OMERO_DATA_DIR" ]; then
    rm -rf $OMERO_DATA_DIR
fi
mkdir -p $OMERO_DATA_DIR
omero config set omero.data.dir $OMERO_DATA_DIR

