#!/bin/bash

echo "CREATE USER $OMERO_DB_USER PASSWORD '$OMERO_DB_PASS'" | \
    su - postgres -c psql
su - postgres -c "createdb -O '$OMERO_DB_USER' '$OMERO_DB_NAME'"

# If you are using PostgreSQL 8.4 you must run:
#su - postgres -c "createlang plpgsql '$OMERO_DB_NAME'"

psql -P pager=off -h localhost -U "$OMERO_DB_USER" -l
