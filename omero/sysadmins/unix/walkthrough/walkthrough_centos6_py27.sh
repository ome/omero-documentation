#!/bin/bash
set -e -u -x
source settings.env

#start-step01: As root, install dependencies

yum -y install epel-release
yum -y install centos-release-SCL

# installed for convenience
yum -y install unzip wget tar

# install Java
yum -y install java-1.8.0-openjdk

# install Ice
#start-recommended-ice
curl -o /etc/yum.repos.d/zeroc-ice-el6.repo \
http://download.zeroc.com/Ice/3.5/el6/zeroc-ice-el6.repo

yum -y install db53 db53-utils mcpp
# Now install ice
mkdir /tmp/ice-download
cd /tmp/ice-download

wget http://downloads.openmicroscopy.org/ice/experimental/Ice-3.5.1-b1-centos6-sclpy27-x86_64.tar.gz

tar -zxvf /tmp/ice-download/Ice-3.5.1-b1-centos6-sclpy27-x86_64.tar.gz

# Install under /opt
mv Ice-3.5.1-b1-centos6-sclpy27-x86_64 /opt/Ice-3.5.1

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

set +u
source /opt/rh/python27/enable
set -u
pip install zeroc-ice
#end-supported-ice


yum -y install \
	python27 \
	python27-virtualenv \
	python27-numpy \
	libjpeg-devel \
	libpng-devel \
	libtiff-devel \
	zlib-devel \
	hdf5-devel \
	freetype-devel \
	expat-devel

# TODO: this installs a lot of unecessary packages:
yum -y groupinstall "Development Tools"

set +u
source /opt/rh/python27/enable
set -u
easy_install pip

export PYTHONWARNINGS="ignore:Unverified HTTPS request"
pip install -r requirements_centos6_py27.txt

# install Postgres
# Postgres, reconfigure to allow TCP connections
yum -y install http://yum.postgresql.org/9.4/redhat/rhel-6-x86_64/pgdg-centos94-9.4-2.noarch.rpm
yum -y install postgresql94-server postgresql94

service postgresql-9.4 initdb
sed -i.bak -re 's/^(host.*)ident/\1md5/' /var/lib/pgsql/9.4/data/pg_hba.conf
chkconfig postgresql-9.4 on
service postgresql-9.4 start

#end-step01

#start-step02: As root, create an omero system user and directory for the OMERO repository
useradd -m omero

mkdir -p "$OMERO_DATA_DIR"
chown omero "$OMERO_DATA_DIR"
#start-configuration-env-ice35
echo source \~omero/omero-centos6py27.env >> ~omero/.bashrc
#end-configuration-env-ice35
#start-configuration-env-ice36
echo "source /opt/rh/python27/enable" >> ~omero/.bashrc
echo "export PATH=\"/opt/rh/python27/root/usr/bin:$PATH\"" >> ~omero/.bashrc
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
cp settings.env omero-.env ./linux/step04_all_omero.sh setup_omero_db.sh ~omero 
#end-copy-omeroscript
set +u
source /opt/rh/python27/enable
set -u
cd ~omero
SERVER=http://downloads.openmicroscopy.org/latest/omero5.2/server-ice35.zip
wget $SERVER
unzip -q OMERO.server*
ln -s OMERO.server-*/ OMERO.server
OMERO.server/bin/omero config set omero.data.dir "$OMERO_DATA_DIR"
OMERO.server/bin/omero config set omero.db.name "$OMERO_DB_NAME"
OMERO.server/bin/omero config set omero.db.user "$OMERO_DB_USER"
OMERO.server/bin/omero config set omero.db.pass "$OMERO_DB_PASS"
OMERO.server/bin/omero db script -f OMERO.server/db.sql --password "$OMERO_ROOT_PASS"
psql -h localhost -U "$OMERO_DB_USER" "$OMERO_DB_NAME" < OMERO.server/db.sql
#end-step04

#start-step05: As root, install a Web server: Nginx or Apache
#start-nginx
set +u
source /opt/rh/python27/enable
set -u

cat << EOF > /etc/yum.repos.d/nginx.repo
[nginx]
name=nginx repo
baseurl=http://nginx.org/packages/centos/\$releasever/\$basearch/
gpgcheck=0
enabled=1
EOF

yum -y install nginx
pip install -r ~omero/OMERO.server/share/web/requirements-py27-nginx.txt

# set up as the omero user.
su - omero -c "bash -eux setup_omero_nginx.sh"

mv /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.disabled
cp ~omero/OMERO.server/nginx.conf.tmp /etc/nginx/conf.d/omero-web.conf

service nginx start
#end-nginx

#start-apache
#start-copy
cp setup_omero_apache24.sh ~omero
#end-copy
#start-configure-apache: As the omero system user, configure OMERO.web
OMERO.server/bin/omero config set omero.web.application_server wsgi
OMERO.server/bin/omero web config apache24 --http "$OMERO_WEB_PORT" > OMERO.server/apache.conf.tmp
OMERO.server/bin/omero web syncmedia
#end-configure-apache
#start-apache-install
set +u
source /opt/rh/python27/enable
set -u

yum -y install httpd24-httpd python27-mod_wsgi

# Install OMERO.web requirements
pip install -r ~omero/OMERO.server/share/web/requirements-py27-apache.txt

cp ~omero/OMERO.server/apache.conf.tmp /opt/rh/httpd24/root/etc/httpd/conf.d/omero-web.conf

chkconfig httpd24-httpd on
service httpd24-httpd start
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
