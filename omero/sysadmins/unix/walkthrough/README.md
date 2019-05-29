Example OMERO Linux install scripts
===================================

This directory contains examples of installing OMERO on clean Ubuntu 14.04,
Ubuntu 16.04, Ubuntu 18.04, Debian 9 and CentOS 7 64-bit systems, see
https://docs.openmicroscopy.org/latest/omero/sysadmins/unix/server-installation.html

Copy the files from this directory, then run one of the install scripts,

	bash install_centos7_nginx.sh
	bash install_ubuntu1404_nginx.sh
	bash install_ubuntu1604_nginx.sh
	bash install_ubuntu1804_nginx.sh
	bash install_debian9_nginx.sh


corresponding to the required OS and web platform.

Usernames and passwords can be customized in `settings.env`.

Documentation generation
========================
To generate a walkthrough file corresponding to a given OS, run the
`autogenerate.sh` script, the OS is specified as a parameter e.g.
	
	OS=ubuntu1604 bash autogenerate.sh

The walkthrough file is used for the omero documention e.g.
https://docs.openmicroscopy.org/latest/omero/sysadmins/unix/server-centos7-ice36.html
but it should not be executed.

To generate all the walkthroughs, run the following command
	
	bash autogenerate.sh
