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

*******************
Server Installation
*******************

This section provides guidance on how to install and set up OMERO.server on
any of the supported UNIX and UNIX-like platforms. Specific walkthroughs are
provided for several systems, with detailed step-by-step instructions.
However, reading through the :doc:`unix/server-installation` first
is recommended as this explains the entire process rather than just being a
series of commands.

.. toctree::
    :maxdepth: 1
    :titlesonly:

    unix/server-installation
    unix/server-centos6-ice36
    unix/server-centos7-ice36
    unix/server-ubuntu-ice36
    unix/server-debian9-ice36
    unix/server-install-homebrew
    unix/server-binary-repository
    unix/server-postgresql
    advanced-install

********************
OMERO.web Deployment
********************

OMERO.web is a python client of the OMERO platform that provides a
web-based UI and JSON API.
This section provides guidance on how to install and set up OMERO.web on
any of the supported UNIX and UNIX-like platforms. Specific walkthroughs are
provided for several systems, with detailed step-by-step instructions.
OMERO.web can be either deployed with the OMERO.server or **separately** from 
the OMERO.server. Deploying separately is **recommended**.



However, reading through the :doc:`unix/install-web/web-deployment` first
is recommended.

.. toctree::
    :maxdepth: 1
    :titlesonly:

    unix/install-web/web-deployment
    unix/install-web/walkthrough/omeroweb-install-centos7-ice3.6
    unix/install-web/walkthrough/omeroweb-install-debian-ice3.6
    unix/install-web/walkthrough/omeroweb-install-ubuntu-ice3.6
    unix/install-web/walkthrough/omeroweb-install-with-server-centos7-ice3.6
    unix/install-web/walkthrough/omeroweb-install-with-server-debian-ice3.6
    unix/install-web/walkthrough/omeroweb-install-with-server-ubuntu-ice3.6


***************************************
OMERO.web Maintenance and Customization
***************************************

This sectin contains instructions for administering, customizing your OMERO.web installation.

.. toctree::
    :maxdepth: 1
    :titlesonly:

    unix/install-web
    customization
    omeroweb-upgrade


********************************
Server Maintenance and Upgrading
********************************

This section contains instructions for administering, troubleshooting,
backing-up, and upgrading your server installation.

.. toctree::
    :maxdepth: 1
    :titlesonly:

    cli/index
    troubleshooting
    server-backup-and-restore
    server-upgrade
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
