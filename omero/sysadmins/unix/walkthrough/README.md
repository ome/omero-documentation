Example OMERO Linux install scripts
===================================

This directory contains examples of installing OMERO on clean Ubuntu 14.04 and CentOS 6 64-bit systems, see http://www.openmicroscopy.org/site/support/omero5/sysadmins/unix/server-linux-walkthrough.html

Copy the files from this directory, then run one of

    bash install.sh ubuntu1404 nginx
    bash install.sh centos6 nginx
    bash install.sh centos6 apache

To install OMERO 5.1 add `omero51` as an argument, e.g.

    bash install.sh centos6 nginx omero51

Usernames and passwords can be customized in `settings.env`.

