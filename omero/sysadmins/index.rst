##################################
System Administrator Documentation
##################################

*****************
Server Background
*****************

.. toctree::
    :maxdepth: 2
    :titlesonly:

    whatsnew
    server-overview
    system-requirements
    version-requirements
    server-setup-examples
    limitations
    server-permissions
    admins-with-restricted-privileges
    mapping-restricted-admins

************
Installation
************

This section provides guidance on how to install and set up OMERO.server
and OMERO.web on any of the supported UNIX and UNIX-like platforms.
Following the installation links below you will find specific walkthroughs
provided for several systems, with detailed step-by-step instructions.
Reading through the :doc:`unix/server-installation` and
:doc:`unix/install-web/web-deployment` pages first
is recommended as this explains the entire process rather than just being a
series of commands.

.. toctree::
    :maxdepth: 1
    :titlesonly:

    unix/server-installation
    unix/install-web/web-deployment
    unix/server-binary-repository
    unix/server-postgresql
    advanced-install

.. toctree::
    :maxdepth: 1
    :titlesonly:
    :hidden:

    unix/server-centos6-ice36
    unix/server-centos7-ice36
    unix/server-ubuntu-ice36
    unix/server-debian9-ice36
    unix/server-install-homebrew

*************************
Maintenance and Upgrading
*************************

This section contains instructions for administering, troubleshooting,
backing-up, and upgrading your installation.

.. toctree::
    :maxdepth: 1
    :titlesonly:

    cli/index
    troubleshooting
    server-backup-and-restore
    server-upgrade
    omeroweb-upgrade
    unix/install-web
    UpgradeCheck
    repository-move
    windows-migration

.. _index-optimizing-server:

*******************************
Optimizing Server Configuration
*******************************

This section discusses the options for configuring OMERO.server for optimum
performance and security.

.. toctree::
    :maxdepth: 2
    :titlesonly:

    server-security
    server-ldap
    server-performance
    search
    fs-upload-configuration
    server-advanced-configuration
    omero-home-prefix
    config
    server-syslog

.. _index-public-data:

*************************************
Optimizing OMERO as a Data Repository
*************************************

This section explains how to customize the appearance and functionality of
OMERO clients to host images for groups or public viewing.

.. toctree::
    :maxdepth: 2
    :titlesonly:

    public
    customization

***********************
Data Import and Storage
***********************

This section contains details of how OMERO.fs allows you to import and store
data with OMERO 5.

.. toctree::
    :maxdepth: 2
    :titlesonly:

    dropbox
    in-place-import
    import-scenarios
