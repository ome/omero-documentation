#!/bin/bash

yum -y install epel-release

curl -o /etc/yum.repos.d/zeroc-ice-el7.repo \
	http://download.zeroc.com/Ice/3.5/el7/zeroc-ice-el7.repo

yum -y install \
	unzip \
	wget \
	java-1.8.0-openjdk \
	ice ice-python ice-servers

yum -y install \
	python-pip python-devel python-virtualenv \
	numpy scipy python-matplotlib python-pillow python-tables

# Django
pip install 'Django<1.9'

# Postgres, reconfigure to allow TCP connections
yum -y install http://yum.postgresql.org/9.4/redhat/rhel-7-x86_64/pgdg-centos94-9.4-2.noarch.rpm
yum -y install postgresql94-server postgresql94

PGSETUP_INITDB_OPTIONS=--encoding=UTF8 /usr/pgsql-9.4/bin/postgresql94-setup initdb
sed -i.bak -re 's/^(host.*)ident/\1md5/' /var/lib/pgsql/9.4/data/pg_hba.conf

# Workaround to get postgresql running inside Docker
if [ "${container:-}" = docker ]; then
	sed -i 's/OOMScoreAdjust/#OOMScoreAdjust/' \
        	/usr/lib/systemd/system/postgresql-9.4.service
	systemctl daemon-reload
fi

systemctl start postgresql-9.4.service
systemctl enable postgresql-9.4.service
