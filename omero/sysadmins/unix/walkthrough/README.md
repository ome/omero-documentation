Example OMERO Linux install scripts
===================================

This directory contains examples of installing OMERO on clean Ubuntu 14.04,
Ubuntu 16.04, Debian 8, CentOS 6 and CentOS 7 64-bit systems, see
http://docs.openmicroscopy.org/latest/omero/sysadmins/unix/index.html

Copy the files from this directory, then run one of the install scripts,

	bash install_centos6.sh
	bash install_centos6_py27_nginx.sh
	bash install_centos6_py27_ius_nginx.sh
	bash install_centos7_nginx.sh
	bash install_debian8_nginx.sh
	bash install_ubuntu1404_nginx.sh
	bash install_ubuntu1604_nginx.sh

corresponding to the required OS and web platform. Note that for CentOS 6
there are separate scripts for Python 2.7, the default being Python 2.6.

Usernames and passwords can be customized in `settings.env`.

Documentation generation
========================
To generate a walkthrough file corresponding to a given OS, run the
`autogenerate.sh` script, the OS is specified as a paramater e.g.
	
	OS=ubuntu1404 bash autogenerate.sh

The walkthrough file is used for the omero documention e.g.
http://docs.openmicroscopy.org/latest/omero/sysadmins/unix/server-linux-walkthrough.html
but it should not be executed.

To generate all the walkthroughs, run the following command
	
	ALL=true bash autogenerate.sh