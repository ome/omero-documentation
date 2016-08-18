#!/bin/bash
set -e -u -x
source settings.env

#start-step01: As root, install dependencies

# epel-release will be pulled as a dependency
yum -y install https://centos6.iuscommunity.org/ius-release.rpm

# installed for convenience
yum -y install unzip wget tar bc

# install Java
yum -y install java-1.8.0-openjdk

# install dependencies

yum -y install \
	python27 \
	python27-devel \
	libjpeg-devel \
	libpng-devel \
	libtiff-devel \
	hdf5-devel \
	zlib-devel \
	freetype-devel

# install pip and virtualenv using Python 2.6 
yum -y install python-pip

pip install --upgrade virtualenv

#if virtualenv is not installed (unlikely)
#yum -y install python27-pip
#pip2.7 install virtualenv

# TODO: this installs a lot of unecessary packages:
yum -y groupinstall "Development Tools"

export PYTHONWARNINGS="ignore:Unverified HTTPS request"
# install Ice
#start-recommended-ice
curl -o /etc/yum.repos.d/zeroc-ice-el6.repo \
http://download.zeroc.com/Ice/3.5/el6/zeroc-ice-el6.repo

yum -y install db53 db53-utils mcpp
mkdir /tmp/ice-download
cd /tmp/ice-download

wget http://downloads.openmicroscopy.org/ice/experimental/Ice-3.5.1-b1-centos6-iuspy27-x86_64.tar.gz

tar -zxvf /tmp/ice-download/Ice-3.5.1-b1-centos6-iuspy27-x86_64.tar.gz

# Install under /opt
mv Ice-3.5.1-b1-centos6-iuspy27-x86_64 /opt/Ice-3.5.1

# make path to Ice globally accessible
# if globally set, there is no need to export LD_LIBRARY_PATH
echo /opt/Ice-3.5.1/lib64 > /etc/ld.so.conf.d/ice-x86_64.conf
ldconfig
#end-recommended-ice
#start-supported-ice
cd /etc/yum.repos.d
wget https://zeroc.com/download/rpm/zeroc-ice-el6.repo

yum -y install gcc-c++
yum -y install db53 db53-utils
yum -y install ice-all-runtime ice-all-devel

yum -y install openssl-devel bzip2-devel expat-devel

virtualenv -p /usr/bin/python2.7 /home/omero/omeroenv
set +u
source /home/omero/omeroenv/bin/activate
set -u

/home/omero/omeroenv/bin/pip2.7 install "zeroc-ice>3.5,<3.7"

deactivate
#end-supported-ice


# install Postgres
# Postgres, reconfigure to allow TCP connections
yum -y install http://yum.postgresql.org/9.4/redhat/rhel-6-x86_64/pgdg-centos94-9.4-2.noarch.rpm
yum -y install postgresql94-server postgresql94

service postgresql-9.4 initdb
sed -i.bak -re 's/^(host.*)ident/\1md5/' /var/lib/pgsql/9.4/data/pg_hba.conf
chkconfig postgresql-9.4 on
service postgresql-9.4 start

#end-step01

#start-step01.1: virtual env

# Install the OMERO dependencies in a virtual environment
# Create virtual env.
# -p only required if virtualenv has been installed with python 2.6

virtualenv -p /usr/bin/python2.7 /home/omero/omeroenv
set +u
source /home/omero/omeroenv/bin/activate
set -u
/home/omero/omeroenv/bin/pip install --upgrade pip

/home/omero/omeroenv/bin/pip2.7 install -r requirements_centos6_py27_ius.txt

deactivate
#end-step01.1

#start-step02: As root, create an omero system user and directory for the OMERO repository
useradd -m omero

mkdir -p "$OMERO_DATA_DIR"
chown omero "$OMERO_DATA_DIR"
#start-configuration-env-ice35
echo source \~omero/omero-centos6py27ius.env >> ~omero/.bashrc
#end-configuration-env-ice35
#start-configuration-env-ice36
echo "export PATH=\"/home/omero/omeroenv/bin:$PATH\"" >> ~omero/.bashrc
#end-configuration-env-ice36
#end-step02

#start-step03: As root, create a database user and a database

echo "CREATE USER $OMERO_DB_USER PASSWORD '$OMERO_DB_PASS'" | \
    su - postgres -c psql
su - postgres -c "createdb -E UTF8 -O '$OMERO_DB_USER' '$OMERO_DB_NAME'"

psql -P pager=off -h localhost -U "$OMERO_DB_USER" -l
#end-step03

#start-step04: As the omero system user, install the OMERO.server
#start-copy-omeroscript
cp settings.env step04_all_omero.sh setup_omero_db.sh ~omero
#end-copy-omeroscript
#start-release-ice35
cd ~omero
SERVER=http://downloads.openmicroscopy.org/latest/omero5.2/server-ice35.zip
wget $SERVER -O OMERO.server-ice35.zip
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
OMERO.server/bin/omero db script -f OMERO.server/db.sql "" "" "$OMERO_ROOT_PASS"
OMERO.server/bin/omero db script -f OMERO.server/db.sql --password "$OMERO_ROOT_PASS"
psql -h localhost -U "$OMERO_DB_USER" "$OMERO_DB_NAME" < OMERO.server/db.sql
#end-step04

#start-step05: As root, install a Web server: Nginx or Apache
#start-nginx
cat << EOF > /etc/yum.repos.d/nginx.repo
[nginx]
name=nginx repo
baseurl=http://nginx.org/packages/centos/\$releasever/\$basearch/
gpgcheck=0
enabled=1
EOF

#install nginx
yum -y install nginx

virtualenv -p /usr/bin/python2.7 /home/omero/omeroenv
set +u
source /home/omero/omeroenv/bin/activate
set -u

# Install OMERO.web requirements
file=~omero/OMERO.server/share/web/requirements-py27-nginx.txt
/home/omero/omeroenv/bin/pip2.7 install -r $file
#start-configure-nginx: As the omero system user, configure OMERO.web
OMERO.server/bin/omero config set omero.web.application_server wsgi-tcp
OMERO.server/bin/omero web config nginx --http "$OMERO_WEB_PORT" > OMERO.server/nginx.conf.tmp
#end-configure-nginx
mv /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.disabled
cp ~omero/OMERO.server/nginx.conf.tmp /etc/nginx/conf.d/omero-web.conf

service nginx start
#end-nginx

#start-apache
#start-copy
cp setup_omero_apache22.sh ~omero
#end-copy
#start-configure-apache: As the omero system user, configure OMERO.web
OMERO.server/bin/omero config set omero.web.application_server wsgi
OMERO.server/bin/omero web config apache --http "$OMERO_WEB_PORT" > OMERO.server/apache.conf.tmp
OMERO.server/bin/omero web syncmedia
#end-configure-apache
#start-apache-install
#install Apache 2.2
yum -y install httpd

# install mod_wsgi compiled against 2.7
yum -y install python27-mod_wsgi

virtualenv -p /usr/bin/python2.7 /home/omero/omeroenv
set +u
source /home/omero/omeroenv/bin/activate
set -u

# Install OMERO.web requirements
file=~omero/OMERO.server/share/web/requirements-py27-apache.txt
# introduce in 5.2.0
if [ -f $file ]; then
	/home/omero/omeroenv/bin/pip2.7 install -r $file
fi
deactivate


# Add virtual env python to the python-path parameter of the WSGIDaemonProcess directive
sed -i 's/\(python-path\=\)/\1\/home\/omero\/omeroenv\/lib64\/python2.7\/site-packages:/' ~omero/OMERO.server/apache.conf.tmp

cp ~omero/OMERO.server/apache.conf.tmp /etc/httpd/conf.d/omero-web.conf

chkconfig httpd on
service httpd start
#end-apache-install
#end-apache
#end-step05

#start-step06: As root, run the scripts to start OMERO and OMERO.web automatically

cp omero-init.d /etc/init.d/omero
chmod a+x /etc/init.d/omero

cp omero-web-init.d /etc/init.d/omero-web
chmod a+x /etc/init.d/omero-web

chkconfig --del omero
chkconfig --add omero
chkconfig --del omero-web
chkconfig --add omero-web
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
#start-selinux

if [ $(getenforce) != Disabled ]; then
    yum -y install policycoreutils-python
    setsebool -P httpd_read_user_content 1
    setsebool -P httpd_enable_homedirs 1
    semanage port -a -t http_port_t -p tcp 4080
fi
#end-selinux
