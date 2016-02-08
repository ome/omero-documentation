#!/bin/bash

yum -y install epel-release

curl -o /etc/yum.repos.d/zeroc-ice-el6.repo \
	http://download.zeroc.com/Ice/3.5/el6/zeroc-ice-el6.repo

yum -y install \
	unzip \
	wget \
	java-1.7.0-openjdk \
	ice ice-python ice-servers

yum -y install \
	python-pip python-devel python-virtualenv \
	numpy scipy python-matplotlib Cython \
	gcc \
	libjpeg-devel \
	libpng-devel \
	libtiff-devel \
	zlib-devel \
	hdf5-devel

# Requires gcc {libjpeg,libpng,libtiff,zlib}-devel
pip install 'Pillow<3.0'
pip install numexpr==1.4.2
# Requires gcc, Cython, hdf5-devel
pip install tables==2.4.0

# Django
pip install Django==1.6.11

# Postgres, reconfigure to allow TCP connections
yum -y install http://yum.postgresql.org/9.4/redhat/rhel-6-x86_64/pgdg-centos94-9.4-1.noarch.rpm
yum -y install postgresql94-server postgresql94

service postgresql-9.4 initdb
sed -i.bak -re 's/^(host.*)ident/\1md5/' /var/lib/pgsql/9.4/data/pg_hba.conf
chkconfig postgresql-9.4 on
service postgresql-9.4 start
