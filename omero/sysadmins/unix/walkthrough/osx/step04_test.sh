
#!/usr/bin/env bash
# Start up server, perform some simple test, shutdown again.

set -e
set -u
set -x

export PATH=/usr/local/bin:$PATH
export HTTPPORT=${HTTPPORT:-8080}
export ROOT_PASSWORD=${ROOT_PASSWORD:-omero_root_password}

# Start PostgreSQL
pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log -w start

# Start the server
omero admin start


if [ -f $(brew --prefix omero53)/var/log/Blitz-0.log ]; then
    d=10;
    while ! grep "OMERO.blitz now accepting connections" $(brew --prefix omero53)/var/log/Blitz-0.log ;
        do
            sleep 10;
            d=$[$d -1];
            if [ $d -lt 0 ]; then
                exit 1;
            fi;
        done
else
    echo "File not found!"
    exit 1
fi

# Start OMERO.web
omero web start
nginx -c $(brew --prefix omero53)/etc/nginx.conf

# Check OMERO version
omero version | grep -v UNKNOWN

# Test simple fake import
omero login -s localhost -u root -w $ROOT_PASSWORD
touch test.fake
omero import test.fake
omero logout

# Test simple Web connection
WEB_HOST="localhost:${HTTPPORT}" OMERO_ROOT_PASS=$ROOT_PASSWORD bash ../linux/test/test_login_to_web.sh

# Stop OMERO.web
nginx -c $(brew --prefix omero53)/etc/nginx.conf -s stop
omero web stop

# Stop the server
omero admin stop

# Stop PostgreSQL
pg_ctl -D /usr/local/var/postgres -m fast stop
