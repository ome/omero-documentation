#!/bin/bash

yum -y install epel-release
yum -y install centos-release-SCL

curl -o /etc/yum.repos.d/zeroc-ice-el6.repo \
	http://download.zeroc.com/Ice/3.5/el6/zeroc-ice-el6.repo

yum -y install \
	unzip \
	wget \
	tar

yum -y install \
	java-1.8.0-openjdk \
	db53 db53-utils mcpp

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
pip install tables matplotlib

# Cap Pillow version due to a limitation in OMERO.figure with v3.0.0
pip install "Pillow<3.0"

# Django
pip install "Django>=1.8,<1.9"

# Postgres, reconfigure to allow TCP connections
yum -y install http://yum.postgresql.org/9.4/redhat/rhel-6-x86_64/pgdg-centos94-9.4-1.noarch.rpm
yum -y install postgresql94-server postgresql94

service postgresql-9.4 initdb
sed -i.bak -re 's/^(host.*)ident/\1md5/' /var/lib/pgsql/9.4/data/pg_hba.conf
chkconfig postgresql-9.4 on
service postgresql-9.4 start

# Now install ice
mkdir /tmp/ice-download
cd /tmp/ice-download

wget http://downloads.openmicroscopy.org/ice/experimental/Ice-3.5.1-b1-centos6-sclpy27-x86_64.tar.gz

tar -zxvf /tmp/ice-download/Ice-3.5.1-b1-centos6-sclpy27-x86_64.tar.gz

# so we don't have to update ICE_HOME
mv Ice-3.5.1-b1-centos6-sclpy27-x86_64 /opt/Ice-3.5.1

# make path to Ice globally accessible
# if globally set, there is no need to export LD_LIBRARY_PATH
echo /opt/Ice-3.5.1/lib64 > /etc/ld.so.conf.d/ice-x86_64.conf
ldconfig
