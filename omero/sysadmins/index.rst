##################################
System Administrator Documentation
##################################

This documentation begins with information aimed at OS-level administrators
and moves on to day-to-day management of OMERO for facility managers (who may
find it useful to read the
:help:`Facility Managers help guide <facility-manager.html>` for an overview
first).

***************
Getting started
***************

The OMERO server system provides storage and processing of image data
which conforms to the :model_doc:`OME Specification <specifications/>`.
It can be run on commodity hardware to provide your own storage needs,
or run site-wide to provide a large-scale collaborative environment.

Although getting started with the server is relatively straightforward,
it does require installing several software systems, and more advanced
usage including backups and integrated logins, needs a knowledgeable system 
administrator.

You may find the :doc:`/users/clients-overview` user guide useful before 
working through the installation and maintenance guides provided in this 
section of the documentation.

The server system is composed of several components, each of which runs
in a separate process but is co-ordinated centrally.

-  :doc:`/developers/server-blitz` - the data server provides access to 
   metadata stored in a relational database as well as the binary image data 
   on disk.
-  :doc:`/sysadmins/dropbox` - a filesystem watcher which notifies the server
   of newly uploaded or modified files and runs a fully automatic import 
   (designed as the first implementation of :doc:`/developers/Server/FS` 
   referred to in the architecture diagram).

If you are interested in building components for the server, modifying
an existing component, or just looking for more background information, there 
is a section about the server within the :doc:`/developers/index`;
the best starting point is the :doc:`/developers/Server` for developers.

.. toctree::
    :maxdepth: 2
    :titlesonly:

    whatsnew
    System requirements: hardware specification and examples <system-requirements>
    Version requirements: supported platforms and versions <version-requirements>
    server-setup-examples
    limitations

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

.. Unclear if we consider the loss of this anchor a breaking change:
.. _maintenance_and_upgrading:

*********
Upgrading
*********

Starting with OMERO 5.6, OMERO.server and OMERO.web installations
are assumed to be separate throughout documentation, each with its own virtualenv.
and installation directory.

.. toctree::
    :maxdepth: 1
    :titlesonly:

    python3-migration
    server-upgrade
    omeroweb-upgrade

.. _server_upgrading:

***********
Maintenance
***********

This section contains instructions for administering, troubleshooting, and
backing-up your installation.

.. toctree::
    :maxdepth: 1
    :titlesonly:

    troubleshooting
    cli/index
    server-backup-and-restore
    unix/install-web
    UpgradeCheck
    repository-move

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
    config
    server-syslog

**************
Managing OMERO
**************

This section contains details on how to manage users, groups and data access
in OMERO. New in OMERO 5.4.0, full administrators can now create restricted
administrators to allow facility managers or other trusted users to carry out
tasks on behalf of all users.

.. toctree::
    :maxdepth: 2
    :titlesonly:

    server-permissions
    restricted-admins

.. seealso::

    - Command Line Interface guides for :doc:`cli/usergroup` and
      :doc:`/users/cli/chown`
    - :help:`Facility Managers help guide <facility-manager.html>`

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

.. _index-public-data:

*************************************
Optimizing OMERO as a Data Repository
*************************************

This section explains how to customize the appearance and functionality of
OMERO clients to host images for groups or public viewing.

.. toctree::
    :maxdepth: 2

    public

.. toctree::
    :maxdepth: 2
    :titlesonly:

    customization
