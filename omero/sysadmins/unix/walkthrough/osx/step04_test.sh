
#!/usr/bin/env bash
# Start up server, perform some simple test, shutdown again.

set -e
set -u
set -x

export PATH=/usr/local/bin:$PATH
export HTTPPORT=${HTTPPORT:-8080}
export ROOT_PASSWORD=${ROOT_PASSWORD:-omero}

# Start PostgreSQL
pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log -w start

# Start the server
omero admin start

# Start OMERO.web
omero web start
nginx -c $(brew --prefix omero52)/etc/nginx.conf

# Check OMERO version
omero version | grep -v UNKNOWN

# Test simple fake import
omero login -s localhost -u root -w $ROOT_PASSWORD
touch test.fake
omero import test.fake
omero logout

# Test simple Web connection
brew install wget
sleep 30
wget --keep-session-cookies --save-cookies cookies.txt http://localhost:$HTTPPORT/webclient/login/ -O csrf_index.html
csrf=$(cat csrf_index.html | grep "name=\'csrfmiddlewaretoken\'"  | sed "s/.* value=\'\(.*\)\'.*/\1/")
post_data="username=root&password=$ROOT_PASSWORD&csrfmiddlewaretoken=$csrf&server=1&noredirect=1"
resp=$(wget --keep-session-cookies --load-cookies cookies.txt --post-data $post_data http://localhost:$HTTPPORT/webclient/login/)
echo "$resp"

# Stop OMERO.web
nginx -c $(brew --prefix omero52)/etc/nginx.conf -s stop
omero web stop

# Stop the server
omero admin stop

# Stop PostgreSQL
pg_ctl -D /usr/local/var/postgres -m fast stop
