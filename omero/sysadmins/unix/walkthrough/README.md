Example OMERO Linux install scripts
===================================

This directory contains examples of installing OMERO on clean
Ubuntu 22.04, Ubuntu 20.04, Debian 10, Rocky Linux 9 64-bit systems, see
https://docs.openmicroscopy.org/latest/omero/sysadmins/unix/server-installation.html

Copy the files from this directory, then run one of the install scripts,

	bash install_ubuntu2204.sh
    bash install_debian10.sh
    bash install_ubuntu2004.sh
    bash install_rocky9.sh


corresponding to the required OS and web platform.

Usernames and passwords can be customized in `settings.env`.

Documentation generation
========================
To generate a walkthrough file corresponding to a given OS, run the
`autogenerate.sh` script, the OS is specified as a parameter e.g.
	
	OS=ubuntu2204 bash autogenerate.sh

The walkthrough file is used for the omero documention e.g.
https://omero.readthedocs.io/en/stable/sysadmins/unix/server-rockylinux9-ice36.html
but it should not be executed.

To generate all the walkthroughs, run the following command
	
	bash autogenerate.sh
