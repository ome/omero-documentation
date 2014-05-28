#!/bin/bash

yum -y install http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm

curl -o /etc/yum.repos.d/zeroc-ice-el6.repo \
	http://download.zeroc.com/Ice/3.5/el6/zeroc-ice-el6.repo

yum -y install \
	unzip \
	wget \
	java-1.7.0-openjdk \
	ice ice-python ice-servers

yum -y install \
	python-pip python-devel \
	numpy scipy python-matplotlib Cython \
	gcc \
	libjpeg-devel \
	libpng-devel \
	libtiff-devel \
	zlib-devel \
	hdf5-devel

# Requires gcc {libjpeg,libpng,libtiff,zlib}-devel
pip install pillow
pip install numexpr==1.4.2
# Requires gcc, Cython, hdf5-devel
pip install tables==2.4.0

# Postgres, reconfigure to allow TCP connections
yum -y install http://yum.postgresql.org/9.3/redhat/rhel-6-x86_64/pgdg-centos93-9.3-1.noarch.rpm
yum -y install postgresql93-server postgresql93

service postgresql-9.3 initdb
sed -i.bak -re 's/^(host.*)ident/\1md5/' /var/lib/pgsql/9.3/data/pg_hba.conf
chkconfig postgresql-9.3 on
service postgresql-9.3 start

# Nginx
cat << EOF > /etc/yum.repos.d/nginx.repo
[nginx]
name=nginx repo
baseurl=http://nginx.org/packages/centos/\$releasever/\$basearch/
gpgcheck=0
enabled=1
EOF

yum -y install nginx
